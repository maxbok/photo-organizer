//
//  NSViewController+Children.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 12/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa


extension NSViewController {

    func addMainChildViewController(_ child: NSViewController) {
        addChildViewController(child)

        view.addSubview(child.view)

        child.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            child.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            child.view.topAnchor.constraint(equalTo: view.topAnchor),
            child.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            child.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }

    func removeChildren() {
        childViewControllers.forEach { child in
            child.view.removeFromSuperview()
            child.removeFromParentViewController()
        }
    }

}
