//
//  EventsViewController.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 02/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa

class EventsViewController: NSViewController {

    let events: [Event]

    override var preferredContentSize: NSSize {
        set { }
        get {
            return NSSize(width: 512, height: 600)
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

    lazy var titleLabel: NSTextField = {
        let label = NSTextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isEditable = false
        label.drawsBackground = false
        label.isBordered = false
        label.alignment = .center
        label.font = .systemFont(ofSize: 17)
        return label
    }()

    lazy var processingView: ProcessingView = {
        let view = ProcessingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init?(events: [Event]) {
        self.events = events

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = NSView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(titleLabel)
        view.addSubview(processingView)

        let count: Int = events.reduce(0) {result, event in result + event.days.reduce(0) {result, day in result + day.files.count } }
        titleLabel.stringValue = "Found \(events.count) events with \(count) files"

        createViewConstraints()
    }

    func createViewConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            processingView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            processingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            processingView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6)
            ])
    }
    
}
