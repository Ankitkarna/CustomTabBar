//
//  PBCenterTabBarView.swift
//  CustomTabBar
//
//  Created by Ankit Karna on 1/28/19.
//  Copyright © 2019 Ankit Karna. All rights reserved.
//

import UIKit

class PBCenterTabBarView: PBTabBarView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        makeCircular()
    }

    override func draw(_ rect: CGRect) {
        drawIcons()
    }
    
    private func drawIcons() {
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        self.addSubview(containerView)
        
        imageView.image = image
        titleLabel.text = title
        containerView.backgroundColor = .white
        
        //container view constraints
        containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        containerView.heightAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        
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
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 4.0
        
    }
    
    private func makeCircular() {
        containerView.layer.cornerRadius = containerView.frame.size.height/2.0
        containerView.layer.masksToBounds = true
    }
}
