//
//  NetworkService.swift
//  AvitoInternTest
//
//  Created by Denis Larin on 09.01.2021.
//

import Foundation

import UIKit

class NetworkService {
    
    private init() {}
    static let shared = NetworkService()
    
    private func getOffersFromAssets() -> Offers? {
        guard let asset = NSDataAsset(name: "result"),
              let offers = try? JSONDecoder().decode(Offers.self, from: asset.data)
        else { return nil }
        return offers
    }
    
    public func getOffersFromGithub() -> Offers? {
        guard let url = URL(string: "https://raw.githubusercontent.com/avito-tech/internship/main/result.json"),
              let data = try? Data(contentsOf: url),
              let offers = try? JSONDecoder().decode(Offers.self, from: data)
        else { return getOffersFromAssets() }
        
        return offers
    }
}


