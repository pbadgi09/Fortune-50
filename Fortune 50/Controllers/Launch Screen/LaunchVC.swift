//
//  LaunchVC.swift
//  Fortune 50
//
//  Created by Pranav Badgi on 12/7/22.
//

import UIKit
import Network

final class LaunchVC: UIViewController {
    
    //MARK: - Properties
    
    fileprivate let appIconImageView: UIImageView = {
        let iv                  = UIImageView()
        iv.contentMode          = .scaleAspectFit
        iv.clipsToBounds        = true
        iv.image                = UIImage(named: "appIconRounded")
        iv.setDimensions(150, 150)
        return iv
    }()
    
    
    private let monitor = NWPathMonitor()
    
    private let queue = DispatchQueue(label: "InternetConnectionMonitor")
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllerUI(.systemBackground, true)
        view.addSubview(appIconImageView)
    }
    
    
    
    
    
    
    //MARK: - Layout Sub Views
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        appIconImageView.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: { [weak self] in
            self?.animate()
        })
    }
      
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Helpers
    
    private func animate() {
        UIView.animate(withDuration: 1, animations: {
            let size = self.view.frame.size.width * 2
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            self.appIconImageView.frame = CGRect(x: -(diffX/2), y: diffY/2, width: size, height: size)
        })
        
        UIView.animate(withDuration: 1.2, animations: {
            self.appIconImageView.alpha = 0
        }) { [weak self] done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                    self?.checkIfConnectedToInternet()
                })
            }
        }
    }
    
    
    
    private func checkIfConnectedToInternet() {
        monitor.pathUpdateHandler = { [weak self] pathupdateHadler in
            if pathupdateHadler.status == .satisfied {
                self?.fetchAndShowCompanyListFeed()
            } else {
                self?.presentCompanyListVC()
            }
        }
        monitor.start(queue: queue)
    }
    
    
    
    
    private func stopNetworkMonitoring() {
        monitor.cancel()
    }
    
    
    
    
    
    
    
    private func fetchAndShowCompanyListFeed() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            NetworkService.shared.getCompanyData { result in
                switch result {
                case .success(let success):
                    self.saveToCoreData(success)
                case .failure(let failure):
                    print("DEBUG: Failed to Fetch Data: \(failure.description)")
                }
            }
        }
    }
    
    
    
    
    
   
    
    
    
    
    private func saveToCoreData(_ companyResponse: [CompanyResponse]) {
        for company in companyResponse {
            //  check if exists
            if CoreDataManager.shared.checkIfExists(company.symbol) {
                //  get the isFav property
                let isFavourited = CoreDataManager.shared.getIsFavouritedProperty(company)
                //  save/update in core data
                CoreDataManager.shared.saveUpdateCompanyDetails(company, isFavourited) { done in
                    if done {
                        // saved to CD
                    }
                }
            } else {
                //  save to core data
                CoreDataManager.shared.saveUpdateCompanyDetails(company, false) { done in
                    if done {
                        //  saved to CD
                    }
                }
            }
        }
        presentCompanyListVC()
    }
    
    
    
    
    
    
    private func presentCompanyListVC() {
        let viewController                      = CompanysListVC()
        viewController.cdCompanyResponse        = CoreDataManager.shared.fetchAllCompanys()
        let navController                       = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle    = .fullScreen
        navController.modalTransitionStyle      = .crossDissolve
        present(navController, animated: true)
    }
    
    
    
    
    
    
    
}
