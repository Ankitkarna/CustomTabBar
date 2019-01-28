//
//  PBTabBarControllerBottomLine.swift
//  CustomTabBar
//
//  Created by Ankit Karna on 1/25/19.
//  Copyright © 2019 Ankit Karna. All rights reserved.
//

import UIKit

extension PBTabBarController {
//    func createBottomLine() {
//        guard let currentItem = (containers.filter { $0.value.tag == 0 }).first?.value else { return }
//
//        let lineHeight: CGFloat = 2
//
//        let container = UIView()
//        container.backgroundColor = .clear
//        container.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(container)
//
//        container.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        container.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        container.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        container.heightAnchor.constraint(equalToConstant: lineHeight).isActive = true
//
//
//        let line = UIView()
//        line.backgroundColor = bottomLineColor
//        line.translatesAutoresizingMaskIntoConstraints = false
//        container.addSubview(line)
//        bottomLine = line
//
//        lineLeadingConstraint = bottomLine?.leadingAnchor.constraint(equalTo: currentItem.leadingAnchor)
//        lineLeadingConstraint?.isActive = true
//
//        // add constraints
//        bottomLine?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        bottomLine?.heightAnchor.constraint(equalToConstant: lineHeight).isActive = true
//        bottomLine?.widthAnchor.constraint(equalTo: currentItem.widthAnchor).isActive = true
//    }
//
//    func removeBottomLine() {
//        guard let bottomLine = self.bottomLine else { return }
//
//        bottomLine.superview?.removeFromSuperview()
//        self.bottomLine = nil
//        lineLeadingConstraint?.isActive = false
//        lineLeadingConstraint = nil
//    }
//
//    func setBottomLinePosition(index: Int, animated: Bool = true) {
//
//        guard let itemsCount = tabBar.items?.count, itemsCount > index,
//            let currentItem = tabBar.items?[selectedIndex] else { return }
//
//        lineLeadingConstraint?.isActive = false
//
//        lineLeadingConstraint = bottomLine?.leadingAnchor.constraint(equalTo: currentItem.leadingAnchor)
//        lineLeadingConstraint?.isActive = true
//
//        if animated {
//            UIView.animate(withDuration: bottomLineMoveDuration) { self.bottomLine?.superview?.layoutIfNeeded() }
//        } else {
//            self.bottomLine?.superview?.layoutIfNeeded()
//        }
//    }
}
