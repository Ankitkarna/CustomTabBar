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

    var tabbarBackgroundColor: UIColor = .clear//UIColor(red: 50/255.0, green: 0, blue: 112/255.0, alpha: 1)

    ///the height ratio of center tabbar with respect to tabbar height
    @IBInspectable var centerHeightMultiplier: CGFloat = 1.5

    ///the width ratio of center tabbar with respect to tabbar width
    @IBInspectable var centerWidthMultiplier: CGFloat = 0.25

    //called if viewcontrollers is changed from code
    override var viewControllers: [UIViewController]? {
        didSet {
            if containerView != nil {
                setTabbars()
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.subviews.forEach {
            $0.removeFromSuperview()
        }

        createContainerView()
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

            addCircularTabbarView(at: index)

        }
        formatString += "-(0)-|"

        let constranints = NSLayoutConstraint.constraints(withVisualFormat: formatString,
                                                          options: [],
                                                          metrics: nil,
                                                          views: containersDict)
        containerView.addConstraints(constranints)

    }

    private func createTabBarContainerView(at index: Int) -> UIView {
        guard let containerView = containerView else { fatalError() }


        let tabbarView = UIView(frame: .zero)
        tabbarView.backgroundColor = UIColor(red: 50/255.0, green: 0, blue: 112/255.0, alpha: 1)
        containerView.addSubview(tabbarView)
        tabbarView.translatesAutoresizingMaskIntoConstraints = false

        tabbarView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor).isActive = true

        if index == Int(children.count/2) {
            //add circular chat view
            //constraint for center tabbaritem
            tabbarView.widthAnchor.constraint(equalTo: tabBar.widthAnchor, multiplier: centerWidthMultiplier).isActive = true
            tabbarView.heightAnchor.constraint(equalTo: tabBar.heightAnchor, multiplier: centerHeightMultiplier).isActive = true
        } else {


            //subtract center width from total and divide by total count excluding center
            let multiplier = (1 - centerWidthMultiplier)/CGFloat(children.count - 1)
            tabbarView.widthAnchor.constraint(equalTo: tabBar.widthAnchor, multiplier: multiplier).isActive = true
            tabbarView.heightAnchor.constraint(equalTo: tabBar.heightAnchor).isActive = true
        }

        return tabbarView
    }

    private func addCircularTabbarView(at index: Int) {
        guard let items = tabBar.items as? [PBTabBarItem] else { fatalError("should inherit from PBTabbaritem")}

        let tabbarContainer = containerView.subviews[index]
        let item = items[index]

        let circularView = PBTabBarView()
        circularView.title = item.title
        circularView.image = item.image
        circularView.tag = index
        circularView.translatesAutoresizingMaskIntoConstraints = false

        // add gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PBTabBarController.tapHandler(_:)))
        tapGesture.numberOfTouchesRequired = 1
        circularView.addGestureRecognizer(tapGesture)
        
        tabbarContainer.addSubview(circularView)

        if index == Int(children.count/2) {
            circularView.backgroundColor = item.selectedBackgroundColor
        } else {
            circularView.backgroundColor = item.defaultBackgroundColor
        }


        circularView.heightAnchor.constraint(equalTo: tabbarContainer.widthAnchor, multiplier: 1.0).isActive = true
        circularView.widthAnchor.constraint(equalTo: tabbarContainer.widthAnchor, multiplier: 1).isActive = true
        circularView.centerXAnchor.constraint(equalTo: tabbarContainer.centerXAnchor).isActive = true
        circularView.centerYAnchor.constraint(equalTo: tabbarContainer.centerYAnchor).isActive = true

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


    private func createContainerView() {

        //draw supercontainer view to allow the tabbar to tap beyond the container view
        let superContainerView = view!

        //now draw the container view that will hold all the tabbar views
        containerView = UIView(frame: .zero)
        containerView.backgroundColor = tabbarBackgroundColor
        superContainerView.addSubview(containerView)

        containerView.translatesAutoresizingMaskIntoConstraints = false

        containerView.leadingAnchor.constraint(equalTo: superContainerView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: superContainerView.trailingAnchor).isActive = true
        containerView.heightAnchor.constraint(equalTo: tabBar.heightAnchor, multiplier: centerHeightMultiplier).isActive = true
        containerView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor).isActive = true

        setTabbars()
    }


}
