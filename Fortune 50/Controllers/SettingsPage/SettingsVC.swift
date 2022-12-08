//
//  SettingsVC.swift
//  Fortune 50
//
//  Created by Pranav Badgi on 12/7/22.
//

import UIKit

final class SettingsVC: UIViewController {
    
    //MARK: - Properties
    
    private let currentlySortedByLabel: LabelView = {
        let label               = LabelView(withInset: 0, 0, 0, 0)
        label.alignment         = .center
        label.lines             = 0
        return label
    }()
    
    
    private let sortByCompanyNameButton: ButtonView = {
        let button = ButtonView()
        button.font             = UIFont.boldSystemFont(ofSize: 18)
        button.tintcolor        = .systemBackground
        button.backgroundcolor  = .label
        button.isLargeButton    = true
        button.isRounded        = true
        button.placeholder      = "Sort By Name"
        return button
    }()
    
    private let sortByCompanySymbolButton: ButtonView = {
        let button = ButtonView()
        button.font             = UIFont.boldSystemFont(ofSize: 18)
        button.tintcolor        = .systemBackground
        button.backgroundcolor  = .label
        button.isLargeButton    = true
        button.isRounded        = true
        button.placeholder      = "Sort By Symbol"
        return button
    }()
    
    
    private let stackView: UIStackView = {
        let sv          = UIStackView()
        sv.axis         = .vertical
        sv.spacing      = 16
        sv.distribution = .fillEqually
        sv.alignment    = .fill
        return sv
    }()
    
    
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addRecognizers()
        updateViews()
    }
    
    
    
    
    
    
    //MARK: - Layout Sub Views
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureViews()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Helpers
    
    private func configureUI() {
        configureViewControllerUI(.systemBackground, false)
        configureNavigationBar()
    }
    
    
    
    
    
    
    
    /// Configures the Navigation Bar for Settings Page
    private func configureNavigationBar() {
        title                                                   = "Settings"
        navigationController?.navigationBar.prefersLargeTitles  = true
    }
    
    
    
    
    
    
    
    
    
    /// Configures & Layouts the views
    private func configureViews() {
        //  add sub views
        view.addSubview(currentlySortedByLabel)
        view.addSubview(stackView)
        stackView.addArrangedSubview(sortByCompanyNameButton)
        stackView.addArrangedSubview(sortByCompanySymbolButton)
        
        
        //  layout views
        currentlySortedByLabel.constraint(top: navigationController?.navigationBar.bottomAnchor,
                                          left: view.leftAnchor,
                                          right: view.rightAnchor,
                                          paddingTop: 16,
                                          paddingLeft: 16,
                                          paddingRight: 16)
        
        stackView.constraint(top: currentlySortedByLabel.bottomAnchor,
                             left: view.leftAnchor,
                             right: view.rightAnchor,
                             paddingTop: 32,
                             paddingLeft: 16, paddingRight: 16)
    }
    
    
    
    
    
    
    
    
    /// Update's UI for Label & Buttons on the Main Thread
    private func updateViews() {
        updateLabel()
        roundButtonCorners(sortByCompanyNameButton)
        roundButtonCorners(sortByCompanySymbolButton)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /// Updates the label based on the current sorting method on the main thread
    public func updateLabel() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let currentSortMethod = Preferences.shared.currentSortingMethod()
            switch currentSortMethod {
            case .byCompanyName:
                self.currentlySortedByLabel.setAttributedText("Current Method: ", "Company Name", .label, .label, UIFont.systemFont(ofSize: 16, weight: .regular), UIFont.systemFont(ofSize: 18, weight: .bold))
            case .bySymbol:
                self.currentlySortedByLabel.setAttributedText("Current Method: ", "Company Symbol", .label, .label, UIFont.systemFont(ofSize: 16, weight: .regular), UIFont.systemFont(ofSize: 18, weight: .bold))
            }
        }
    }
    
    
    
    
    
    
    /// Adds recognizers and targets
    private func addRecognizers() {
        sortByCompanyNameButton.addTarget(self, action: #selector(nameButtonTapped), for: .touchUpInside)
        sortByCompanySymbolButton.addTarget(self, action: #selector(symbolButtonTapped), for: .touchUpInside)
    }
    
    
    
    
    
    
    
    
    //MARK: - Selectors
    
    @objc private func nameButtonTapped() {
        sortByCompanyNameButton.bounce { [unowned self] in
            Preferences.shared.setSortMethod(.byCompanyName)
            updateLabel()
        }
    }
    
    
    
    @objc private func symbolButtonTapped() {
        sortByCompanySymbolButton.bounce { [unowned self] in
            Preferences.shared.setSortMethod(.bySymbol)
            updateLabel()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}


//MARK: - Extensions
























































