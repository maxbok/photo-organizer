//
//  ProgressViewController.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 12/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa

class ProgressViewController: ViewController {

    var hint: String? {
        didSet {
            label.stringValue = hint ?? ""
        }
    }

    var progress: Double? {
        didSet {
            if let progress = progress {
                progressIndicator.isIndeterminate = false
                progressIndicator.doubleValue = progress
            } else {
                progressIndicator.isIndeterminate = true
            }
        }
    }

    private lazy var label: NSTextField = {
        let label = NSTextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isEditable = false
        label.drawsBackground = false
        label.isBordered = false
        label.alignment = .center
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    private lazy var progressIndicator: NSProgressIndicator = {
        let bar = NSProgressIndicator()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.style = .bar
        bar.controlSize = .small
        bar.minValue = 0
        bar.maxValue = 1
        return bar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(label)
        view.addSubview(progressIndicator)

        createViewConstraints()
    }

    func createViewConstraints() {
        let margin: CGFloat = 20

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: margin),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),

            progressIndicator.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            progressIndicator.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            progressIndicator.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            progressIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin),
            progressIndicator.widthAnchor.constraint(greaterThanOrEqualToConstant: 300)
            ])
    }
    
}
