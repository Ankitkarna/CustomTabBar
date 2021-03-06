//
//  PBTabBarView.swift
//  CustomTabBar
//
//  Created by Ankit Karna on 1/28/19.
//  Copyright © 2019 Ankit Karna. All rights reserved.
//

import UIKit

class PBTabBarView: UIView {

    var image: UIImage?
    var title: String?
    
    var defaultBackgroundColor: UIColor?

    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.textAlignment = NSTextAlignment.center
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    
    
    private func drawIcons() {
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        self.addSubview(containerView)
        
        imageView.image = image
        titleLabel.text = title
        containerView.backgroundColor = backgroundColor
        
        //container view constraints
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true

        //image view constraints
        imageView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true

        //title label constraints
        titleLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true

        imageView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        titleLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        
    }

    override func draw(_ rect: CGRect) {
        containerView.subviews.forEach {$0.removeFromSuperview()}
        self.drawIcons()
    }
}
