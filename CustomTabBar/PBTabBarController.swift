//
//  PBTabBarController.swift
//  CustomTabBar
//
//  Created by Ankit Karna on 1/25/19.
//  Copyright © 2019 Ankit Karna. All rights reserved.
//

import UIKit

class PBTabBarController: UITabBarController {

    private var containerView: UIView!

    var tabbarBackgroundColor: UIColor = UIColor(red: 50/255.0, green: 0, blue: 112/255.0, alpha: 1)

    ///the height ratio of center tabbar with respect to tabbar height
    @IBInspectable var centerHeightMultiplier: CGFloat = 2.0

    ///the width ratio of center tabbar with respect to tabbar width
    @IBInspectable var centerWidthMultiplier: CGFloat = 0.25
    
    @IBInspectable var tabBarHeight: CGFloat = 80.0

    //called if viewcontrollers is changed from code
    override var viewControllers: [UIViewController]? {
        didSet {
            if containerView != nil {
                setTabbars()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.subviews.forEach {
            $0.removeFromSuperview()
        }

        createContainerView()
    }
    
    private func createContainerView() {
    
        let superContainerView = UIView(frame: .zero)
        superContainerView.backgroundColor = .clear
        view.addSubview(superContainerView)
        superContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        superContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        superContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        superContainerView.heightAnchor.constraint(equalToConstant: tabBarHeight * centerHeightMultiplier).isActive = true
        //superContainerView.heightAnchor.constraint(equalTo: tabBar.heightAnchor, multiplier: centerHeightMultiplier).isActive = true
        superContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        containerView = UIView(frame: .zero)
        containerView.backgroundColor = tabbarBackgroundColor
        superContainerView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.leadingAnchor.constraint(equalTo: superContainerView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: superContainerView.trailingAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: tabBarHeight).isActive = true
        //containerView.heightAnchor.constraint(equalTo: tabBar.heightAnchor, multiplier: 1.0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        setTabbars()
    }


    private func setTabbars() {
        //should be atleast 3
        //and odd multiples of 2
        precondition(children.count >= 3 && children.count % 2 != 0)

        containerView?.subviews.forEach {$0.removeFromSuperview()}

        var containersDict: [String: UIView] = [:]

        var formatString: String = ""
        for index in 0..<children.count {
            let tabBarView = createTabBarContainerView(at: index)
            tabBarView.tag = index
            containersDict["container\(index)"] = tabBarView

            if index == children.startIndex {
                formatString = "H:|-(0)-[container0]"
            } else {
                formatString += "-(0)-[container\(index)]"
            }

        }
        formatString += "-(0)-|"

        let constranints = NSLayoutConstraint.constraints(withVisualFormat: formatString,
                                                          options: [],
                                                          metrics: nil,
                                                          views: containersDict)
        containerView.addConstraints(constranints)

    }

    private func createTabBarContainerView(at index: Int) -> PBTabBarView {
        guard let containerView = containerView else { fatalError() }
         guard let items = tabBar.items as? [PBTabBarItem] else { fatalError("should inherit from PBTabbaritem")}
        
        let item = items[index]

        var tabbarView: PBTabBarView

        if index == Int(children.count/2) {
            tabbarView = PBCenterTabBarView(frame: .zero)
            containerView.addSubview(tabbarView)
            tabbarView.translatesAutoresizingMaskIntoConstraints = false
            //constraint for center tabbaritem
            tabbarView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: centerWidthMultiplier).isActive = true
            tabbarView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1.0).isActive = true
            let constraint = NSLayoutConstraint(item: containerView,
                                                attribute: .centerY,
                                                relatedBy: .equal,
                                                toItem: tabbarView,
                                                attribute: .centerY,
                                                multiplier: centerHeightMultiplier,
                                                constant: 0)
            containerView.addConstraint(constraint)
            
            tabbarView.backgroundColor = .clear
            
        } else {
            tabbarView = PBTabBarView(frame: .zero)
            containerView.addSubview(tabbarView)
            tabbarView.translatesAutoresizingMaskIntoConstraints = false
            //subtract center width from total and divide by total count excluding center
            let multiplier = (1 - centerWidthMultiplier)/CGFloat(children.count - 1)
            tabbarView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: multiplier).isActive = true
            tabbarView.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
            tabbarView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
            
            tabbarView.backgroundColor = tabbarBackgroundColor
        }
        
        tabbarView.title = item.title
        tabbarView.image = item.image
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PBTabBarController.tapHandler(_:)))
        tapGesture.numberOfTouchesRequired = 1
        tabbarView.addGestureRecognizer(tapGesture)

        return tabbarView
    }


    @objc private func tapHandler(_ gesture: UIGestureRecognizer) {
        guard let gestureView = gesture.view,
            let viewControllers = viewControllers else { fatalError() }

        let currentIndex = gestureView.tag
        let controller = children[currentIndex]

        if let shouldSelect = delegate?.tabBarController?(self, shouldSelect: controller)
            , !shouldSelect {
            return
        }

        if selectedIndex != currentIndex {
            selectedIndex = gestureView.tag

        } else if selectedIndex == currentIndex {

            if let navVC = viewControllers[selectedIndex] as? UINavigationController {
                navVC.popToRootViewController(animated: true)
            }
        }
        delegate?.tabBarController?(self, didSelect: controller)
    }

}
