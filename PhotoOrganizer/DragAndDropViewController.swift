//
//  DragAndDropViewController.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 28/10/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa

class DragAndDropViewController: NSViewController {

    override var preferredContentSize: NSSize {
        set { }
        get {
            return NSSize(width: 512, height: 512)
        }
    }

    override var preferredMinimumSize: NSSize {
        set { }
        get { return preferredContentSize }
    }

    override var preferredMaximumSize: NSSize {
        set { }
        get { return preferredContentSize }
    }

    let fileUtils = FileUtils()

    weak var delegate: DragAndDropViewControllerDelegate?

    lazy var draggingView: DraggingView = {
        let view = DraggingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()

    override func loadView() {
        self.view = NSView()
    }

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

