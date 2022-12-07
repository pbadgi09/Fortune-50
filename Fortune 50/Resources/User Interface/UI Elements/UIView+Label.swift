//
//  UIView+Label.swift
//  TestApp
//
//  Created by Pranav Badgi on 12/6/22.
//

import UIKit

final class LabelView: UILabel {
    
    //MARK: - Properties
    var topInset    : CGFloat
    var bottomInset : CGFloat
    var leftInset   : CGFloat
    var rightInset  : CGFloat
    
    var fontName: UIFont = UIFont.systemFont(ofSize: 14, weight: .semibold) { didSet { updateViews() } }
    
    var titlePlaceholder: String = "" { didSet { updateViews() } }
    
    var alignment: NSTextAlignment = .left { didSet { updateViews() } }
    
    var titlePlaceholderColor: UIColor = .label { didSet { updateViews() } }
    
    var lines: Int = 0 { didSet { updateViews() } }
    
    var isInteractable: Bool = false { didSet { updateViews() } }
    
    
    
    //MARK: - Init
    init(withInset topInset: CGFloat, _ bottomInset: CGFloat, _ leftInset: CGFloat, _ rightInset: CGFloat) {
        self.topInset       = topInset
        self.bottomInset    = bottomInset
        self.leftInset      = leftInset
        self.rightInset     = rightInset
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK: - Override
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
    
    
    //MARK: - Helpers
    private func updateViews() {
        font                        = fontName
        text                        = titlePlaceholder
        textAlignment               = alignment
        textColor                   = titlePlaceholderColor
        numberOfLines               = lines
        isUserInteractionEnabled    = isInteractable
    }
    
}




//MARK: - Extension
extension UILabel {
    
    func setAttributedText( _ strOne: String, _ strTwo: String, _ colorOne: UIColor, _ colorTwo: UIColor, _ fontOne: UIFont, _ fontTwo: UIFont) {
        let attributedText = NSMutableAttributedString(string: "\(strOne)", attributes: [
            NSAttributedString.Key.font: fontOne, NSAttributedString.Key.foregroundColor: colorOne
        ])
        attributedText.append(NSAttributedString(string: "\(strTwo)", attributes: [
            NSAttributedString.Key.font: fontTwo, NSAttributedString.Key.foregroundColor: colorTwo
        ]))
        self.attributedText = attributedText
    }
    
}









