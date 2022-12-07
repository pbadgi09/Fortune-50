//
//  UIView+AnchorExtension.swift
//  TestApp
//
//  Created by Pranav Badgi on 12/6/22.
//

import UIKit

extension UIView {
    
    //MARK: - Properties
    public var width: CGFloat {
        return frame.size.width
    }
    
    public var height: CGFloat {
        return frame.size.height
    }
    
    public var top: CGFloat {
        return frame.origin.y
    }
    
    public var bottom: CGFloat {
        return frame.origin.y + frame.size.height
    }
    
    public var left: CGFloat {
        return frame.origin.x
    }
    
    public var right: CGFloat {
        return frame.origin.x + frame.size.width
    }
    
    
    //MARK: - Helpers
    func constraint(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil,
                    paddingTop: CGFloat = 0, paddingLeft: CGFloat = 0, paddingBottom: CGFloat = 0, paddingRight: CGFloat = 0,
                    width: CGFloat? = nil, height: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    
    func centerX(_ inView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: inView.centerXAnchor).isActive = true
    }
    
    
    func centerY(_ inView: UIView, _ leftAnchor: NSLayoutXAxisAnchor? = nil, _ paddingLeft: CGFloat = 0, _ constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: inView.centerYAnchor, constant: constant).isActive = true
        if let leftAnchor = leftAnchor {
            constraint(left: leftAnchor, paddingLeft: paddingLeft)
        }
    }
    
    
    func setHeight(height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    
    func setDimensions(_ height: CGFloat, _ width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    
    func add(_ subViews: UIView...) {
        for subView in subViews { self.addSubview(subView) }
    }
    
    
    func bounce(_ completion: @escaping () -> ()) {
        isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: { [weak self] in
            self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
        }) { done in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear) { [weak self] in
                self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            } completion: { [weak self] _ in
                self?.isUserInteractionEnabled = true
                completion()
            }
        }
    }
    
}




















