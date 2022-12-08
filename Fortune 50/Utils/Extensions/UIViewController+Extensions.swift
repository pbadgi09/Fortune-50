//
//  UIViewController+Extensions.swift
//  TestApp
//
//  Created by Pranav Badgi on 12/6/22.
//

import UIKit

extension UIViewController {
    
    //MARK: - Helpers
    
    func configureViewControllerUI(_ bgColor: UIColor, _ hideNavBar: Bool) {
        view.backgroundColor                            = bgColor
        navigationController?.navigationBar.isHidden    = hideNavBar
        let tap                                         = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView                        = false
        view.addGestureRecognizer(tap)
    }
    
    func format(with mask: String, str: String) -> String {
        let formattedStr    = str.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result          = ""
        var index           = formattedStr.startIndex
        
        for char in mask where index < formattedStr.endIndex {
            if char == "X" {
                result.append(formattedStr[index])
                index = formattedStr.index(after: index)
            } else {
                result.append(char)
            }
        }
        return result
    }
    
    
    func roundButtonCorners(_ button: UIButton) {
        DispatchQueue.main.async {
            let height = button.frame.size.height
            button.layer.cornerRadius = height / 2
        }
    }
    
}
