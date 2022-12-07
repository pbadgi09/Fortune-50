//
//  UIView+Button.swift
//  TestApp
//
//  Created by Pranav Badgi on 12/6/22.
//

import UIKit

final class ButtonView: UIButton {
    
    //MARK: - Properties
    var placeholder: String = "" { didSet { updateViews() } }
    
    var padding: CGFloat = 10 { didSet { updateViews() } }
    
    var font: UIFont = UIFont.systemFont(ofSize: 14, weight: .bold) { didSet { updateViews() } }
    
    var tintcolor: UIColor = .label { didSet { updateViews() } }
    
    var backgroundcolor: UIColor = .secondarySystemBackground { didSet { updateViews() } }
    
    var cornerRadius: CGFloat = 0 { didSet { updateViews() } }
    
    var buttonImage: UIImage? { didSet { updateViews() } }
    
    var isRounded: Bool = false { didSet { updateViews() } }
    
    var isLargeButton: Bool = false { didSet { updateViews() } }
    
    var isAttributedButton: Bool = false { didSet { updateViews() } }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helpers
    
    private func updateViews() {
        setButtonImage()
        checkIfRounded()
        checkIfLargeButton()
        checkIfAttributedButton()
        setTitleColor(tintcolor, for: .normal)
        backgroundColor         = backgroundcolor
        tintColor               = tintcolor
        titleLabel?.font        = font
        clipsToBounds           = true
        layer.cornerRadius      = cornerRadius
    }
    
    
    private func setButtonImage() {
        if let image = buttonImage {
            setImage(image, for: .normal)
            imageView?.contentMode = .scaleAspectFit
            semanticContentAttribute = .forceLeftToRight
            imageEdgeInsets = UIEdgeInsets(top: 0, left: padding-16, bottom: 0, right: 0)
        }
    }
    
    
    
    private func checkIfRounded() {
        if isRounded {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.layer.cornerRadius = self.frame.size.height / 2
            }
        }
    }
    
    
    
    private func checkIfLargeButton() {
        if isLargeButton {
            contentEdgeInsets       = UIEdgeInsets(top: padding+10, left: padding+16, bottom: padding+10, right: padding+16)
        } else {
            contentEdgeInsets       = UIEdgeInsets(top: padding, left: padding+16, bottom: padding, right: padding+16)
        }
    }
    
    
    
    private func checkIfAttributedButton() {
        if !isAttributedButton {
            setTitle(placeholder, for: .normal)
        }
    }
    
}



//MARK: - Extension
extension UIButton {
    
    func setAttributedTitle(_ strOne: String, _ strTwo: String, _ colorOne: UIColor, _ colorTwo: UIColor, _ fontOne: UIFont, _ fontTwo: UIFont) {
        let attributedTitle = NSMutableAttributedString(string: "\(strOne)", attributes: [
            NSAttributedString.Key.font: fontOne, NSAttributedString.Key.foregroundColor: colorOne
        ])
        attributedTitle.append(NSAttributedString(string: "\(strTwo)", attributes: [
            NSAttributedString.Key.font: fontTwo, NSAttributedString.Key.foregroundColor: colorTwo
        ]))
        setAttributedTitle(attributedTitle, for: .normal)
    }
    
}



