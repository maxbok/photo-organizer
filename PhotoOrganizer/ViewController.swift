//
//  ViewController.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 28/10/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    let fileUtils = FileUtils()

    lazy var draggingView: DraggingView = {
        let view = DraggingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(draggingView)

        createViewConstraints()
    }

    private func createViewConstraints() {
        NSLayoutConstraint.activate([
            draggingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            draggingView.topAnchor.constraint(equalTo: view.topAnchor),
            draggingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            draggingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }

}

