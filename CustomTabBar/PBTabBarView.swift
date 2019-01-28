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

    private var imageView: UIImageView?
    private var titleLabel: UILabel?

    override func layoutSubviews() {
        super.layoutSubviews()
        self.makeCircular()
    }

    private func drawIcons() {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let textLabel = UILabel()
        textLabel.text = title
        textLabel.textAlignment = NSTextAlignment.center
        self.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false

        imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: textLabel.topAnchor).isActive = true

        textLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        imageView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textLabel.setContentHuggingPriority(.defaultLow, for: .vertical)

        self.imageView = imageView
        self.titleLabel = textLabel
    }

    override func draw(_ rect: CGRect) {
        self.drawIcons()
    }

    func makeCircular() {
        self.layer.cornerRadius = frame.size.height/2.0
        self.layer.masksToBounds = true
    }

}
