//
//  ViewController.swift
//  AvitoInternTest
//
//  Created by Denis Larin on 09.01.2021.
//

import UIKit

protocol OfferViewProtocol: class {
    var presenter: OfferPresenterProtocol! { get set }
    var offers: [Offer] { get set }
    var offersHeader: String? { get set }
    var offerButtonStates: (String, String)? { get set }
    var selected: Int? { get set }
    func setupCloseButton()
    func setupOffersCollection()
    func setupOfferButton()
    func showOffer(_ offer: Offer)
}

class OfferViewController: UIViewController , OfferViewProtocol{

    var presenter: OfferPresenterProtocol!
    let configurator: OfferConfiguratorProtocol = OfferConfigurator()
    
    let closeButton = UIButton()
    var offersCollection: UICollectionView!
    let offerButton = UIButton()
    
    var offers = [Offer]()
    var offersHeader: String?
    var offerButtonStates: (String, String)?
    private var lastSelected: Int?
    var selected: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()
    }
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc
    private func closeButtonClicked() {
        presenter.closeButtonClicked()
    }
    
    @objc
    private func offerButtonClicked() {
        presenter.offerButtonClicked()
    }
    
    func showOffer(_ offer: Offer) {
        let alert = UIAlertController(title: offer.title, message: nil, preferredStyle: .alert)
        let okOffer = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okOffer)
        present(alert, animated: true, completion: nil)
    }
    

}

extension OfferViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let index = lastSelected {
            if index != indexPath.item {
                offers[index].isSelected = false
            } else {
                selected = nil
            }
        }
        lastSelected = indexPath.item
        offers[indexPath.item].isSelected.toggle()
        selected = offers[indexPath.item].isSelected ? indexPath.item : nil
        updateOfferButton()
        
        collectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = UIScreen.main.bounds.width - 30
            let text = offers[indexPath.item].description ?? ""
            let title = offers[indexPath.item].title
            let approximateWidthOfDescription = view.frame.width * 0.5
            let size = CGSize(width: approximateWidthOfDescription, height: 1100)
            let textAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
            let titleAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .semibold)]
            let textHeight = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: textAttributes, context: nil).height * 2
            let titleHeight = NSString(string: title).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: titleAttributes, context: nil).height + 40
            
            return CGSize(width: width, height: textHeight + titleHeight)
    }
    
}

extension OfferViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { fatalError() }
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: OffersCollectionHeaderView.reuseId, for: indexPath) as? OffersCollectionHeaderView else { fatalError() }
        headerView.label.text = offersHeader
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OfferCollectionViewCell.reuseId, for: indexPath) as! OfferCollectionViewCell
        
        cell.configure(with: offers[indexPath.item])
        
        return cell
    }
    
}

extension OfferViewController {
    
    func setupCloseButton() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(UIImage(named: "CloseIconTemplate"), for: .normal)
        view.addSubview(closeButton)

        
        closeButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        
    }
    
    func setupOffersCollection() {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        layout.headerReferenceSize = CGSize(width: (UIScreen.main.bounds.size.width - 25), height: 120)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 30, height: 150)
        
        offersCollection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        offersCollection.translatesAutoresizingMaskIntoConstraints = false
        offersCollection.backgroundColor = .white
        offersCollection.register(OfferCollectionViewCell.self, forCellWithReuseIdentifier: OfferCollectionViewCell.reuseId)
        offersCollection.register(OffersCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: OffersCollectionHeaderView.reuseId)
        view.addSubview(offersCollection)
        
        offersCollection.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        offersCollection.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        offersCollection.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 5).isActive = true
        offersCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        offersCollection.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        offersCollection.alwaysBounceVertical = true
        
        offersCollection.delegate = self
        offersCollection.dataSource = self
    }
    
    func setupOfferButton() {
        offerButton.translatesAutoresizingMaskIntoConstraints = false
        offerButton.layer.cornerRadius = 10
        offerButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        updateOfferButton()
        view.addSubview(offerButton)
        offerButton.addTarget(self, action: #selector(offerButtonClicked), for: .touchUpInside)
        
        offerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        offerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        offerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        offerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func updateOfferButton() {
        if let offerButtonStates = offerButtonStates {
            if selected != nil {
                UIView.animate(withDuration: 0.5) {
                    self.offerButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
                    self.offerButton.setTitle(offerButtonStates.1, for: .normal)
                    self.offerButton.setTitleColor(.white, for: .normal)
                }
                
            } else {
                UIView.animate(withDuration: 0.5) {
                    self.offerButton.backgroundColor = #colorLiteral(red: 0.9421952963, green: 0.9813895822, blue: 0.9980943799, alpha: 1)
                    self.offerButton.setTitle(offerButtonStates.0, for: .normal)
                    self.offerButton.setTitleColor(.systemBlue, for: .normal)
                }
            }
        }
    }
    
}
