//
//  Offer.swift
//  AvitoInternTest
//
//  Created by Denis Larin on 09.01.2021.
//

import Foundation

struct Offers: Codable {
    let status: String?
    let result: Result
    
}

struct Result: Codable {
    let title: String
    let actionTitle: String
    let selectedActionTitle: String
    let list: [Offer]
    
}

struct Offer: Codable {
    let id: String
    let title: String
    let description: String?
    let price: String
    let icon: Icon
    public var isSelected: Bool
    public var image: Data {
        get {
            guard let url = URL(string: icon.the52X52),
                  let imageData = try? Data(contentsOf: url)
            else { return Data() }

            return imageData
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case price = "price"
        case icon = "icon"
        case isSelected = "isSelected"
    }
}

struct Icon: Codable {
    let the52X52: String
    
    enum CodingKeys: String, CodingKey {
        case the52X52 = "52x52"
    }
}
