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
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let height                                      = self.addToFavouriteButton.frame.size.height
            self.addToFavouriteButton.layer.cornerRadius    = height / 2
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    /// Adds recognizers and targets
    private func addRecognizers() {
        addToFavouriteButton.addTarget(self, action: #selector(addToFavouritesButtonTapped), for: .touchUpInside)
    }
    
    
    
    
    
    
    
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
    
    
    
    
    private func configureFavouritesButton(_ isFavourited: Bool) {
        if isFavourited {
            addToFavouriteButton.placeholder = "Remove from Favourites"
            addToFavouriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            addToFavouriteButton.placeholder = "Add to Favourites"
            addToFavouriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    
    
    
    
    
    
    
    private func handleAddToFavourites() {
        print("DEBUG: Handle Add to Fav Here")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Selectors
    
    @objc private func addToFavouritesButtonTapped() {
        addToFavouriteButton.bounce { [unowned self] in
            handleAddToFavourites()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}


//MARK: - Extensions
























































