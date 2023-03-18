//
//  RMCharacterListView.swift
//  YouTutorial1
//
//  Created by Bruce Fraser on 3/9/23.
//

import UIKit

protocol RMCharacterListViewDelegate: AnyObject {
    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCharacter character: RMCharacter)
}

final class RMCharacterListView: UIView {

    public weak var delegate: RMCharacterListViewDelegate?
    private let viewmodel = CharacterListViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .vertical
         layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
         collectionView.isHidden = true
         collectionView.alpha = 0
         collectionView.translatesAutoresizingMaskIntoConstraints = false
         collectionView.register(RMCharacterCollectionViewCell.self,
                                 forCellWithReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier)
         collectionView.register(RMFooterLoadingCollectionReusableView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                 withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier)
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
     }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(spinner, collectionView)
        
        addConstraints()
        spinner.startAnimating()
        viewmodel.delegate = self
        viewmodel.fetchCharacters()
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
            NSLayoutConstraint.activate([
                spinner.widthAnchor.constraint(equalToConstant: 100),
                spinner.heightAnchor.constraint(equalToConstant: 100),
                spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
                spinner.centerYAnchor.constraint(equalTo: centerYAnchor),

                collectionView.topAnchor.constraint(equalTo: topAnchor),
                collectionView.leftAnchor.constraint(equalTo: leftAnchor),
                collectionView.rightAnchor.constraint(equalTo: rightAnchor),
                collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
        }
    
    private func setUpCollectionView() {
       collectionView.dataSource = viewmodel
       collectionView.delegate = viewmodel
      
    }
}

extension RMCharacterListView: RMCharacterListViewViewModelDelegate {
    func didLoadInitialCharacters() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData() // Initial fetch
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
    
    func didSelectCharacter(_ character: RMCharacter) {
        delegate?.rmCharacterListView(self, didSelectCharacter: character)
    }
    
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath]) {
        collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: newIndexPaths)
        }
    }
}
