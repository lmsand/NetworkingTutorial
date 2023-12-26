//
//  ContentView.swift
//  NetworkingTutorial
//
//  Created by lexi sanders on 12/26/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CoinsViewModel()
    
    var body: some View {
        VStack {
            Text("\(viewModel.coin): \(viewModel.price)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
