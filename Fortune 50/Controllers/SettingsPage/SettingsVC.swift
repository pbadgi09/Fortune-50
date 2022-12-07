//
//  SettingsVC.swift
//  Fortune 50
//
//  Created by Pranav Badgi on 12/7/22.
//

import UIKit

final class SettingsVC: UIViewController {
    
    //MARK: - Properties
    
    
    
    
    
    
    
    
    
    
    
    
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
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    
    
    
    
    
    private func configureViews() {
        //  add sub views
        
        
        
        //  layout views
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    /// Adds recognizers and targets
    private func addRecognizers() {
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /// Adds delegates
    private func addDelegates() {
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /// Executes APIs
    private func executeAPIs() {
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Selectors
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}


//MARK: - Extensions
























































