//
//  DragAndDropViewController.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 28/10/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa

class DragAndDropViewController: ViewController {

    weak var delegate: DragAndDropViewControllerDelegate?

    enum State {
        case ready, processing
    }

    var state: State = .ready {
        didSet {
            draggingView.isEnabled = state == .ready
        }
    }

    lazy var draggingView: DraggingView = {
        let view = DraggingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        preferredContentSize = NSSize(width: 512, height: 512)

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

