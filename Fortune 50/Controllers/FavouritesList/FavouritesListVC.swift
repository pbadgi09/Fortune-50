//
//  FavouritesListVC.swift
//  Fortune 50
//
//  Created by Pranav Badgi on 12/7/22.
//

import UIKit

final class FavouritesListVC: UIViewController {
    
    //MARK: - Properties
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let collectionView: UICollectionView = {
        let layout                      = UICollectionViewFlowLayout()
        layout.sectionInset             = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing       = 16
        let cv                          = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor              = .systemBackground
        cv.showsVerticalScrollIndicator = false
        cv.register(CompanyListFeedCell.self, forCellWithReuseIdentifier: CompanyListFeedCell.identifier)
        return cv
    }()
    
    
    
    
    
    
    
    
    
    //MARK: - Properties
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addRecognizers()
        addDelegates()
        executeAPIs()
    }
    
    
    
    
    
    
    //MARK: - Layout Sub Views
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureViews()
    }
    
    
    
    //MARK: - Deinit
    deinit { print("Deinit: \(self) deinitialized") }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Helpers
    
    private func configureUI() {
        configureViewControllerUI(.systemBackground, false)
        configureNavigationBar()
    }
    
    
    
    private func configureNavigationBar() {
        title                                                   = "Favourites"
        navigationController?.navigationBar.prefersLargeTitles  = true
        navigationItem.searchController                         = searchController
    }
    
    
    
    
    
    
    private func configureViews() {
        //  add sub views
        view.addSubview(collectionView)
        
        
        //  layout views
        collectionView.constraint(top: navigationController?.navigationBar.bottomAnchor,
                                  left: view.leftAnchor,
                                  bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                  right: view.rightAnchor, paddingLeft: 16, paddingRight: 16)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    /// Adds recognizers and targets
    private func addRecognizers() {
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /// Adds delegates
    private func addDelegates() {
        searchController.searchBar.delegate = self
        collectionView.delegate             = self
        collectionView.dataSource           = self
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /// Executes APIs
    private func executeAPIs() {
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Selectors
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}


//MARK: - Extensions

//MARK: - Collection View Delegate & Data Source
extension FavouritesListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompanyListFeedCell.identifier, for: indexPath) as! CompanyListFeedCell
        return cell
    }
    
}


//MARK: - Collection View Delegate Flow Layout
extension FavouritesListVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width   = collectionView.frame.size.width
        let height  = width / 5
        return CGSize(width: width, height: height)
    }
    
}


//MARK: - Search Bar Controller Delegate
extension FavouritesListVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("DEBUG: Searching for: \(searchText)")
    }
    
}























































