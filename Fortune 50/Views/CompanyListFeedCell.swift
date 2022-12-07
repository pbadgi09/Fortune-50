//
//  CompanyListFeedCell.swift
//  Fortune 50
//
//  Created by Pranav Badgi on 12/7/22.
//

import UIKit

final class CompanyListFeedCell: UICollectionViewCell {
    
    
    //MARK: - Properties
    static let identifier = "CompanyListFeedCell"
    
    fileprivate let companyNameLabel: LabelView = {
        let label               = LabelView(withInset: 0, 0, 0, 0)
        label.lines             = 0
        label.titlePlaceholder  = "Loading.."
        return label
    }()
    
    
    fileprivate let companySymbolLabel: LabelView = {
        let label                       = LabelView(withInset: 10, 10, 10, 10)
        label.lines                     = 0
        label.backgroundColor           = .label
        label.titlePlaceholderColor     = .systemBackground
        label.layer.cornerRadius        = 10
        label.clipsToBounds             = true
        label.titlePlaceholder          = "····"
        label.fontName                  = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    fileprivate let favouritesIcon: UIButton = {
        let button                      = UIButton(type: .system)
        button.tintColor                = .label
        button.imageView?.contentMode   = .scaleAspectFit
        return button
    }()
    
    
    
    
    
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor     = .secondarySystemBackground
        clipsToBounds       = true
        layer.cornerRadius  = 16
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    
    //MARK: - Layout Sub Views
    override func layoutSubviews() {
        super.layoutSubviews()
        configureViews()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Helpers
    
    private func configureViews() {
        addSubview(companySymbolLabel)
        addSubview(favouritesIcon)
        addSubview(companyNameLabel)
        
        //  layout views
        companySymbolLabel.centerY(self)
        companySymbolLabel.constraint(left: leftAnchor, paddingLeft: 10)
        
        favouritesIcon.centerY(self)
        favouritesIcon.constraint(right: rightAnchor, paddingRight: 8)
        
        companyNameLabel.centerY(self)
        companyNameLabel.constraint(left: companySymbolLabel.rightAnchor,
                                    right: favouritesIcon.leftAnchor,
                                    paddingLeft: 10,
                                    paddingRight: 10)
        
    }
    
    
    
    
    
    
    
    
    func configureCellUI(_ companyResponse: CDCompanyResponse) {
        let symbol      = companyResponse.symbol
        let companyName = companyResponse.name
        companySymbolLabel.text = symbol
        companyNameLabel.text   = companyName
        if companyResponse.isFavourited {
            favouritesIcon.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favouritesIcon.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Selectors
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

