//
//  OfferCollection.swift
//  AvitoInternTest
//
//  Created by Denis Larin on 09.01.2021.
//

import Foundation

import UIKit

class OfferCollectionViewCell: UICollectionViewCell {
    static let reuseId = "OfferCell"
    
    private let cellImage = UIImageView()
    private let cellTitle = UILabel()
    private let cellDescription = UILabel()
    private let cellPrice = UILabel()
    private let cellCheckmark = UIImageView(image: UIImage(named: "checkmark"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8470588235)
        
        cellTitle.font = .systemFont(ofSize: 20, weight: .semibold)
        cellTitle.numberOfLines = 0
        
        cellDescription.font = .systemFont(ofSize: 14, weight: .light)
        cellDescription.numberOfLines = 0
        
        cellPrice.font = .systemFont(ofSize: 14, weight: .semibold)
        
        self.addSubview(cellImage)
        self.addSubview(cellTitle)
        self.addSubview(cellDescription)
        self.addSubview(cellPrice)
        self.addSubview(cellCheckmark)
    
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        cellImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        cellImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        cellImage.widthAnchor.constraint(equalTo: cellImage.heightAnchor).isActive = true
        
        cellTitle.translatesAutoresizingMaskIntoConstraints = false
        cellTitle.leftAnchor.constraint(equalTo: cellImage.rightAnchor, constant: 15).isActive = true
        cellTitle.topAnchor.constraint(equalTo: cellImage.topAnchor, constant: 5).isActive = true
        cellTitle.rightAnchor.constraint(equalTo: cellCheckmark.leftAnchor, constant: -10).isActive = true
        
        cellDescription.translatesAutoresizingMaskIntoConstraints = false
        cellDescription.leftAnchor.constraint(equalTo: cellTitle.leftAnchor).isActive = true
        cellDescription.topAnchor.constraint(equalTo: cellTitle.bottomAnchor, constant: 5).isActive = true
        cellDescription.rightAnchor.constraint(equalTo: cellTitle.rightAnchor).isActive = true
        
        cellPrice.translatesAutoresizingMaskIntoConstraints = false
        cellPrice.leftAnchor.constraint(equalTo: cellTitle.leftAnchor).isActive = true
        cellPrice.topAnchor.constraint(equalTo: cellDescription.bottomAnchor, constant: 10).isActive = true
        
        cellCheckmark.translatesAutoresizingMaskIntoConstraints = false
        cellCheckmark.topAnchor.constraint(equalTo: cellTitle.centerYAnchor).isActive = true
        cellCheckmark.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        cellCheckmark.heightAnchor.constraint(equalToConstant: 20).isActive = true
        cellCheckmark.widthAnchor.constraint(equalTo: cellCheckmark.heightAnchor).isActive = true
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with offer: Offer) {
        cellImage.image = UIImage(data: offer.image)
        cellTitle.text = offer.title
        cellDescription.text = offer.description
        cellPrice.text = offer.price
        cellCheckmark.isHidden = !offer.isSelected
    }
    
}

class OffersCollectionHeaderView: UICollectionReusableView {
    
    static let reuseId = "OffersCollectionHeaderView"
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "string", size: 25)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(label)
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        label.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -15).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
