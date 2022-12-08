//
//  CompanyDetailsVC.swift
//  Fortune 50
//
//  Created by Pranav Badgi on 12/7/22.
//

import UIKit

final class CompanyDetailsVC: UIViewController {
    
    //MARK: - Properties
    
    //  Symbol Label
    private let symbolLabel: LabelView = {
        let label                       = LabelView(withInset: 16, 16, 16, 16)
        label.backgroundColor           = .label
        label.titlePlaceholderColor     = .systemBackground
        label.fontName                  = UIFont.boldSystemFont(ofSize: 25)
        label.layer.cornerRadius        = 16
        label.clipsToBounds             = true
        return label
    }()
    
    //  Market Cap Details
    private let marketCapLabel: LabelView = {
        let label               = LabelView(withInset: 0, 0, 0, 0)
        label.titlePlaceholder  = "Market Cap"
        label.alignment         = .center
        label.fontName          = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    private let fmtLabel: LabelView = {
        let label                       = LabelView(withInset: 12, 12, 10, 10)
        label.alignment                 = .center
        label.backgroundColor           = .systemBlue.withAlphaComponent(0.5)
        label.titlePlaceholderColor     = .label
        label.layer.cornerRadius        = 16
        label.clipsToBounds             = true
        return label
    }()
    
    private let longFmtLabel: LabelView = {
        let label                       = LabelView(withInset: 12, 12, 10, 10)
        label.alignment                 = .center
        label.backgroundColor           = .systemGreen.withAlphaComponent(0.5)
        label.titlePlaceholderColor     = .label
        label.layer.cornerRadius        = 16
        label.clipsToBounds             = true
        return label
    }()
    
    private let rawLabel: LabelView = {
        let label                       = LabelView(withInset: 12, 12, 10, 10)
        label.alignment                 = .center
        label.backgroundColor           = .systemYellow.withAlphaComponent(0.5)
        label.titlePlaceholderColor     = .label
        label.layer.cornerRadius        = 16
        label.clipsToBounds             = true
        return label
    }()
    
    private let marketCapStackView: UIStackView = {
        let sv              = UIStackView()
        sv.spacing          = 16
        sv.axis             = .vertical
        sv.distribution     = .fillEqually
        sv.alignment        = .fill
        return sv
    }()
    
    
    private let addToFavouriteButton: ButtonView = {
        let button              = ButtonView()
        button.font             = UIFont.boldSystemFont(ofSize: 18)
        button.tintcolor        = .systemBackground
        button.backgroundcolor  = .label
        button.isLargeButton    = true
        return button
    }()
    
    
    
    
    //MARK: - Properties
    
    var isCompanyFavourited = false
    
    var companyResponse: CDCompanyResponse? {
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
    
    
     
    
    
    
    
    
    
    
    //MARK: - Helpers
    
    
    
    /// Configures the UI for this view controller
    private func configureUI() {
        configureViewControllerUI(.systemBackground, false)
        configureNavigationBar()
    }
    
    
    
    
    
    /// Configures the navigation bar for this view controller
    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles  = true
    }
    
    
    
    
    
    
    
    /// Configures & Layout's the view for this view controller
    private func configureViews() {
        //  add sub views
        view.addSubview(symbolLabel)
        view.addSubview(marketCapStackView)
        marketCapStackView.addArrangedSubview(marketCapLabel)
        marketCapStackView.addArrangedSubview(fmtLabel)
        marketCapStackView.addArrangedSubview(longFmtLabel)
        marketCapStackView.addArrangedSubview(rawLabel)
        view.addSubview(addToFavouriteButton)
        
        //  layout views
        symbolLabel.centerX(view)
        symbolLabel.constraint(top: navigationController?.navigationBar.bottomAnchor, paddingTop: 16)
        
        //  market cap stack view
        marketCapStackView.constraint(top: symbolLabel.bottomAnchor,
                                      left: view.leftAnchor,
                                      bottom: nil,
                                      right: view.rightAnchor,
                                      paddingTop: 32, paddingLeft: 16,
                                      paddingBottom: 0, paddingRight: 16)
        
        //  favourite button
        addToFavouriteButton.constraint(left: view.leftAnchor,
                                        bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                        right: view.rightAnchor,
                                        paddingLeft: 32,
                                        paddingBottom: 16,
                                        paddingRight: 32)
        roundButtonCorners(addToFavouriteButton)
    }
    
    
    
    
    
    
    
    
    /// Adds recognizers and targets
    private func addRecognizers() {
        addToFavouriteButton.addTarget(self, action: #selector(addToFavouritesButtonTapped), for: .touchUpInside)
    }
    
    
    
    
    
    
    
    /// Updates the view's ui with current company response data
    private func updateViews() {
        guard let companyResponse = companyResponse else { return }
        guard let name = companyResponse.name,
              let symbol = companyResponse.symbol,
              let fmt = companyResponse.fmt,
              let longFmt = companyResponse.longFmt,
              let raw = companyResponse.raw else { return }
        
        title               = name
        symbolLabel.text    = symbol
        fmtLabel.setAttributedText("Fmt: ", fmt, .label, .label, UIFont.systemFont(ofSize: 16), UIFont.boldSystemFont(ofSize: 18))
        longFmtLabel.setAttributedText("Long Fmt: ", longFmt, .label, .label, UIFont.systemFont(ofSize: 16), UIFont.boldSystemFont(ofSize: 18))
        rawLabel.setAttributedText("Raw: ", raw, .label, .label, UIFont.systemFont(ofSize: 16), UIFont.boldSystemFont(ofSize: 18))
        configureFavouritesButton(companyResponse.isFavourited)
    }
    
    
    
    
    
    
    
    /// Configures the favourite button based on if the company is added in favourites or not
    /// - Parameter isFavourited: UIButton
    private func configureFavouritesButton(_ isFavourited: Bool) {
        if isFavourited {
            addToFavouriteButton.placeholder = "Remove from Favourites"
            addToFavouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            isCompanyFavourited = true
        } else {
            addToFavouriteButton.placeholder = "Add to Favourites"
            addToFavouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            isCompanyFavourited = false
        }
        roundButtonCorners(addToFavouriteButton)
    }
    
    
    
    
    
    
    
    
    /// Handles add to favourites functionality
    private func handleAddToFavourites() {
        isCompanyFavourited.toggle()
        guard let company = self.companyResponse,
              let symbol = company.symbol else { return }
        CoreDataManager.shared.updateIsFavourite(symbol, isCompanyFavourited) { [weak self] updated in
            guard let self = self else { return }
            if updated {
                self.configureFavouritesButton(self.isCompanyFavourited)
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Selectors
    
    @objc private func addToFavouritesButtonTapped() {
        addToFavouriteButton.bounce { [unowned self] in
            handleAddToFavourites()
        }
    }
    
    
    
    
    
}


















































