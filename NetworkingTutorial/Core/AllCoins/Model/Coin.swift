//
//  Coin.swift
//  NetworkingTutorial
//
//  Created by lexi sanders on 12/26/23.
//

import Foundation

struct Coin: Codable, Identifiable {
    let id: String
    let symbol: String
    let name: String
//    let currentPrice: Double
//    let marketCapRank: Int
}
