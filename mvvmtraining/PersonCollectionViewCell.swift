//
//  PersonCollectionViewCell.swift
//  mvvmtraining
//
//  Created by Unit27 on 07/08/2025.
//

import UIKit

// MARK: - Delegate

protocol PersonCollectionViewCellDelegate: AnyObject {
    func didTapSubscribe()
}

class PersonCollectionViewCell: UICollectionViewCell {
    
    private var personView: PersonView?
    
    weak var delegate: PersonCollectionViewCellDelegate?
    
    var item: PersonResponse? {
        didSet {
            guard let firstName = item?.firstName, let lastName = item?.lastName, let email = item?.email else { return }
            personView?.set(name: firstName, email: email)
        }
    }
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Setup

private extension PersonCollectionViewCell {
    
    func setup() {
        guard personView == nil else { return }
        
        personView = PersonView(action: { [weak self] in
            self?.delegate?.didTapSubscribe()
        })
        
        self.contentView.addSubview(personView!)
        
        NSLayoutConstraint.activate([
            personView!.topAnchor.constraint(equalTo: contentView.topAnchor),
            personView!.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            personView!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            personView!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }
    
}
