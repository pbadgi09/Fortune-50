//
//  CompanysListVC.swift
//  Fortune 50
//
//  Created by Pranav Badgi on 12/7/22.
//

import UIKit

final class CompanysListVC: UIViewController {
    
    //MARK: - Properties
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let favouritesBarButtonItem: UIButton = {
        let button          = UIButton(type: .system)
        button.tintColor    = .label
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        return button
    }()
    
    private let settingsBarButtonItem: UIButton = {
        let button          = UIButton(type: .system)
        button.tintColor    = .label
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        return button
    }()
    
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
    
    var cdCompanyResponse = [CDCompanyResponse]() {
        didSet { collectionView.reloadData() }
    }
    
    var filteredCompanyResponse = [CDCompanyResponse]() {
        didSet { collectionView.reloadData() }
    }
    
    var inSearchMode = false
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
        title                                                   = "Fortune 50"
        navigationController?.navigationBar.prefersLargeTitles  = true
        navigationItem.searchController                         = searchController
        let favouritesButton    = UIBarButtonItem(customView: favouritesBarButtonItem)
        let filterButton        = UIBarButtonItem(customView: settingsBarButtonItem)
        navigationItem.rightBarButtonItems = [favouritesButton, filterButton]
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
        favouritesBarButtonItem.addTarget(self, action: #selector(favouritesBarButtonTapped), for: .touchUpInside)
        settingsBarButtonItem.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
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
    
    
    @objc private func favouritesBarButtonTapped() {
        navigationController?.pushViewController(FavouritesListVC(), animated: true)
    }
    
    
    
    @objc private func settingsButtonTapped() {
        navigationController?.pushViewController(SettingsVC(), animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}


//MARK: - Extensions

//MARK: - Collection View Delegate & Data Source
extension CompanysListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredCompanyResponse.count
        } else {
            return cdCompanyResponse.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var response: CDCompanyResponse!
        let cell            = collectionView.dequeueReusableCell(withReuseIdentifier: CompanyListFeedCell.identifier, for: indexPath) as! CompanyListFeedCell
        if inSearchMode {
            response = filteredCompanyResponse[indexPath.row]
        } else {
            response = cdCompanyResponse[indexPath.row]
        }
        cell.configureCellUI(response)
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var response: CDCompanyResponse!
        if inSearchMode {
            response = filteredCompanyResponse[indexPath.row]
        } else {
            response = cdCompanyResponse[indexPath.row]
        }
        let viewController              = CompanyDetailsVC()
        viewController.companyResponse  = response
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}





//MARK: - Collection View Delegate Flow Layout
extension CompanysListVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width   = collectionView.frame.size.width
        let height  = width / 5
        return CGSize(width: width, height: height)
    }
    
}






//MARK: - Search Bar Controller Delegate
extension CompanysListVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            inSearchMode = true
            filteredCompanyResponse = cdCompanyResponse.filter({ company in
                return company.symbol!.lowercased().contains(searchText.lowercased())
            })
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } else {
            inSearchMode = false
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
}












































