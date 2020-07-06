//
//  UIButton+Extensions.swift
//  lojong
//
//  Created by Gustavo Chaves on 05/07/20.
//  Copyright © 2020 Gustavo Chaves. All rights reserved.
//

import UIKit

extension UIButton{
    class func makeButton(imageNamed: String, target: Any?, action: Selector) -> UIButton {
        let buttonImage = UIImage(named: imageNamed)?.withRenderingMode(.alwaysOriginal)
        let button = UIButton(type: .custom)
        button.setImage(buttonImage, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
    
    func setupConstraints(size: CGSize){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
    }
    
    func setupConstraints(size: CGFloat){
        setupConstraints(size: CGSize(width: size, height: size))
    }
}
