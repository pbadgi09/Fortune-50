//
//  CompanyDetailsVC.swift
//  Fortune 50
//
//  Created by Pranav Badgi on 12/7/22.
//

import UIKit

final class CompanyDetailsVC: UIViewController {
    
    //MARK: - Properties
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Properties
    
    var companyResponse: CompanyResponse? {
        didSet {
            updateViews()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addRecognizers()
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
        navigationController?.navigationBar.prefersLargeTitles  = true
    }
    
    
    
    
    
    
    
    private func configureViews() {
        //  add sub views
        
        
        
        //  layout views
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    /// Adds recognizers and targets
    private func addRecognizers() {
        
    }
    
    
    
    
    
    
    
    private func updateViews() {
        guard let companyResponse = companyResponse else { return }
        title = companyResponse.name
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Selectors
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}


//MARK: - Extensions
























































