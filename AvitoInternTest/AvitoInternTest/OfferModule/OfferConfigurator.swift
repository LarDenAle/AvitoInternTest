//
//  OfferConfigurator.swift
//  AvitoInternTest
//
//  Created by Denis Larin on 09.01.2021.
//

import Foundation

protocol OfferConfiguratorProtocol: class {
    func configure(with viewController: OfferViewController)
}

class OfferConfigurator: OfferConfiguratorProtocol {
    
    func configure(with viewController: OfferViewController) {
        let presenter = OfferPresenter(view: viewController)
        let interactor = OfferInteractor(presenter: presenter)
        let router = OfferRouter(viewController: viewController)

        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    
    }
}
