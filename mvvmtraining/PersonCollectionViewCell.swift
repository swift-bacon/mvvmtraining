//
//  PersonCollectionViewCell.swift
//  mvvmtraining
//
//  Created by Unit27 on 07/08/2025.
//

import UIKit

class PersonCollectionViewCell: UICollectionViewCell {
    
    private var personView: PersonView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension PersonCollectionViewCell {
    
    func setup() {
        guard personView == nil else { return }
        
        personView = PersonView(action: {
            
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
