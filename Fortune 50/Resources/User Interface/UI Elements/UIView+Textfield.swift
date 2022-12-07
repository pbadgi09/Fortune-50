//
//  UIView+Textfield.swift
//  TestApp
//
//  Created by Pranav Badgi on 12/6/22.
//

import UIKit

final class TextFieldView: UITextField {
    
    //MARK: - Properties
    var leftImage: UIImage? { didSet { updateViews() } }
    
    var isImageInteractable: Bool = false { didSet { updateViews() } }
    
    var imageTintColor: UIColor = .black { didSet { updateViews() } }
    
    var leftPadding: CGFloat = 0 { didSet { updateViews() } }
    
    var placeHolderText: String = "" { didSet { updateViews() } }
    
    var placeHolderColor: UIColor = .secondaryLabel { didSet { updateViews() } }
    
    var backgroundcolor: UIColor = .clear { didSet { updateViews() } }
    
    var cornerRadius: CGFloat = 0 { didSet { updateViews() } }
    
    var textfieldHeight: CGFloat = 40 { didSet { updateViews() } }
    
    var textcolor: UIColor = .label { didSet { updateViews() } }
    
    var alignment: NSTextAlignment = .left { didSet { updateViews() } }
    
    var isSecure: Bool = false { didSet { updateViews() } }
    
    var keyboardtype: UIKeyboardType = .default { didSet { updateViews() } }
    
    var bordercolor: UIColor = .clear { didSet { updateViews() } }
    
    var borderwidth: CGFloat = 0 { didSet { updateViews() } }
    
    var textFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .semibold) { didSet { updateViews() } }
    
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - Helpers
    private func updateViews() {
        setLeftImage()
        setHeight(height: textfieldHeight)
        attributedPlaceholder   = NSAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor])
        backgroundColor         = backgroundcolor
        layer.cornerRadius      = cornerRadius
        textColor               = textcolor
        font                    = textFont
        textAlignment           = alignment
        isSecureTextEntry       = isSecure
        keyboardType            = keyboardtype
        layer.borderColor       = bordercolor.cgColor
        layer.borderWidth       = borderwidth
        autocorrectionType      = .no
        autocapitalizationType  = .none
        leftViewMode            = .always
        
        let rightSpacer = UIView()
        rightSpacer.setDimensions(textfieldHeight, 12)
        rightViewMode = .always
        rightView = rightSpacer
    }
    
    
    private func setLeftImage() {
        if let image = leftImage {
            let imageView                       = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 20, height: 20))
            imageView.image                     = image
            imageView.tintColor                 = imageTintColor
            imageView.isUserInteractionEnabled  = isImageInteractable
            imageView.contentMode               = .scaleAspectFit
            var width                           = leftPadding + 20
            if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
                width += 5
            }
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageView)
            leftView = view
        } else {
            let leftSpacer = UIView()
            leftSpacer.setDimensions(textfieldHeight, 12)
            leftView = leftSpacer
        }
    }
    
}
