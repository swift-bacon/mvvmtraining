//
//  ViewController.swift
//  mvvmtraining
//
//  Created by Unit27 on 07/08/2025.
//

import UIKit
import SafariServices

class PeopleViewController: UIViewController {
    
    // MARK: - View model
    
    private let viewModel = PeopleViewModel()
    
    // MARK: - UI elements
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: UIScreen.main.bounds.width, height: 130)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(PersonCollectionViewCell.self, forCellWithReuseIdentifier: "PersonCollectionViewCell")
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        viewModel.delegate = self
        viewModel.getUsers()
    }

}

// MARK: - PersonCollectionViewCellDelegate

extension PeopleViewController: PersonCollectionViewCellDelegate {
    
    func didTapSubscribe() {
        let url = URL(string: "https://www.youtube.com")!
        let viewController = SFSafariViewController(url: url)
        viewController.modalPresentationStyle = .formSheet
        self.present(viewController, animated: true)
    }
    
}

// MARK: - UICollectionViewDataSource

extension PeopleViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.people.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.people[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCollectionViewCell", for: indexPath) as? PersonCollectionViewCell else { return UICollectionViewCell() }
        cell.delegate = self
        cell.item = item
        return cell
    }
    
}

// MARK: - PeopleViewModelDelegate

extension PeopleViewController: PeopleViewModelDelegate {
    
    func didFinish() {
        collectionView.reloadData()
    }
    
    func didFail(error: any Error) {
        print(error)
    }
    
}

// MARK: - View setups

private extension PeopleViewController {
    
    func setup() {
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "People"
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
}

