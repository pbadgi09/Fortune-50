//
//  LaunchVC.swift
//  Fortune 50
//
//  Created by Pranav Badgi on 12/7/22.
//

import UIKit

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
    
    
    
    //MARK: - Deinit
    deinit { print("Deinit: \(self) deinitialized") }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
                    self?.fetchAndShowCompanyListFeed()
                })
            }
        }
    }
    
    
    
    
    
    
    
    private func fetchAndShowCompanyListFeed() {
        let viewController                      = CompanysListVC()
        let navController                       = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle    = .fullScreen
        navController.modalTransitionStyle      = .crossDissolve
        present(navController, animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
