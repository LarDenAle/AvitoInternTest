//
//  OfferRouter.swift
//  AvitoInternTest
//
//  Created by Denis Larin on 09.01.2021.
//

import Foundation

import UIKit

protocol OfferRouterProtocol: class {
    func closeCurrentViewController()
    func nextViewController()
    func applyOffer(_ offer: Offer)
}

class OfferRouter: OfferRouterProtocol {
    
    weak var viewController: OfferViewController!
    
    init(viewController: OfferViewController) {
        self.viewController = viewController
    }
    func closeCurrentViewController() {
        print("Close button clicked")
    }
    
    func nextViewController() {
        print("No action was selected")
    }
    
    func applyOffer(_ offer: Offer) {
        viewController.showOffer(offer)
    }
}
