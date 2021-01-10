//
//  OfferPresenter.swift
//  AvitoInternTest
//
//  Created by Denis Larin on 09.01.2021.
//

import Foundation

protocol OfferPresenterProtocol: class {
    var interactor: OfferInteractorProtocol! { get set }
    var router: OfferRouterProtocol! { get set }
    func configureView()
    func closeButtonClicked()
    func offerButtonClicked()
}

class OfferPresenter: OfferPresenterProtocol {
    func offerButtonClicked() {
        if let index = view.selected {
            router.applyOffer(view.offers[index])
        } else {
            router.nextViewController()
        }
    }
    

    weak var view: OfferViewProtocol!
    var interactor: OfferInteractorProtocol!
    var router: OfferRouterProtocol!
    
    required init(view: OfferViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        guard let offers = interactor.getOffers() else { return }
        for var offer in offers.result.list where offer.isSelected {
            offer.isSelected = false
            view.offers.append(offer)
        }
        view.offersHeader = offers.result.title
        view.offerButtonStates = (offers.result.actionTitle, offers.result.selectedActionTitle)
        view.setupCloseButton()
        view.setupOffersCollection()
        view.setupOfferButton()
    }
    
    func closeButtonClicked() {
        router.closeCurrentViewController()
    }
    
    func actionButtonClicked() {
        if let index = view.selected {
            router.applyOffer(view.offers[index])
        } else {
            router.nextViewController()
        }
    }
}
