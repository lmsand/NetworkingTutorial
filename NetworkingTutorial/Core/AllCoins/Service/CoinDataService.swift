//
//  CoinDataService.swift
//  NetworkingTutorial
//
//  Created by lexi sanders on 12/26/23.
//

import Foundation

class CoinDataService { // background thread, no need for DispatchQueue.main { code }
    
    private let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1&sparkline=false&price_change_percentage=24h&locale=en"
    
    
    func fetchCoinsWithResult(completion: @escaping(Result<[Coin], CoinAPIError>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.unknownError(error: error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.requestFailed(description: "Request Failed")))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                completion(.failure(.invalidStatusCode(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let coins = try? JSONDecoder().decode([Coin].self, from: data)
                completion(.success(coins!))
            } catch {
                print("DEBUG: failed to decode with error \(error)") // get access to error in a catch automatically
                completion(.failure(.jsonParsingFailure))
            }
            
            //guard let coins = try? JSONDecoder().decode([Coin].self, from: data) else { return } // decoding as a specified object, data comes back as array
            
//            for coin in coins {
//                print("DEBUG: coin id \(coin.id)")
//            }
            
            
        }.resume()
    }
    
                // giving viewModel array of coins
    func fetchCoins(completion: @escaping([Coin]?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else { return }
            
            guard let coins = try? JSONDecoder().decode([Coin].self, from: data) else { return } // decoding as a specified object, data comes back as array
            
//            for coin in coins {
//                print("DEBUG: coin id \(coin.id)")
//            }
            completion(coins, nil)
            
        }.resume()
    }
    
    func fetchPrice(coin: String, completion: @escaping(Double) -> Void) {
        let urlString = "https://api.coingecko.com/api/v3/simple/price?ids=\(coin)&vs_currencies=usd"
        guard let url = URL(string: urlString) else { return } // url object
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("DEBUG: Failed with error \(error.localizedDescription)")
//                   self.errorMessage = error.localizedDescription
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
//                 self.errorMessage = "Bad HTTP Response"
                return
            }
            
            guard httpResponse.statusCode == 200 else {
//                 self.errorMessage = "Failed to fetch with status code \(httpResponse.statusCode)"
                return
            }
            
            print("DEBUG: Response code is \(httpResponse.statusCode)")
            
            guard let data = data else { return }
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
            guard let value = jsonObject[coin] as? [String: Double] else {
                print("Failed to parse value")
                return
            }
            guard let price = value["usd"] else { return } // use guard statments to make optional vals non optional
            
//                self.coin = coin.capitalized
//                self.price = "$\(price)"
            print("DEBUG: price in service is \(price)")
            completion(price) // gets the price to the viewModel

        }.resume()
        
    }
}
