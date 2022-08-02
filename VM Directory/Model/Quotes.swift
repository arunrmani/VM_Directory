//
//  Quotes.swift
//  VM Directory
//
//  Created by Safe City Mac 001 on 02/08/2022.
//

import Foundation

struct Quotes:Codable{
    var quotes : [Quote] = []
}
struct Quote: Codable{
    var quote: String?
    var author: String?
}


struct QuotesData{
    
    static let shared = QuotesData()
    
    func getRandomQuote() -> Quote?{
        let quotesArr = loadQuotesDataFromJson()
        return quotesArr[randomPick: 1].first
    }
        private func loadQuotesDataFromJson() -> [Quote] {
        if let url = Bundle.main.url(forResource: "sampleQuotes", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Quotes.self, from: data)
                return jsonData.quotes
            } catch {
                print("error:\(error)")
            }
        }
        return []
    }
}
