//
//  ProcessingView.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 03/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa

class ProcessingView: NSView {

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
        label.stringValue = "Processing…"
        return label
    }()

    private lazy var progressIndicator: NSProgressIndicator = {
        let bar = NSProgressIndicator()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.style = .barStyle
        bar.controlSize = .small
        bar.minValue = 0
        bar.maxValue = 1
        return bar
    }()

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        addSubview(label)
        addSubview(progressIndicator)

        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),

            progressIndicator.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressIndicator.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 6),
            progressIndicator.trailingAnchor.constraint(equalTo: trailingAnchor),
            progressIndicator.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
}
