//
//  OfferInteractor.swift
//  AvitoInternTest
//
//  Created by Denis Larin on 09.01.2021.
//

import Foundation

protocol OfferInteractorProtocol: class {
    func getOffers() -> Offers?
}

class OfferInteractor: OfferInteractorProtocol{

    weak var presenter: OfferPresenterProtocol!
    
    required init(presenter: OfferPresenterProtocol) {
        self.presenter = presenter
    }

    func getOffers() -> Offers? {
        return NetworkService.shared.getOffersFromGithub()
    }
}
