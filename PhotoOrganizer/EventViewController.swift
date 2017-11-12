//
//  EventViewController.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 02/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa

class EventViewController: ViewController {

    weak var delegate: EventViewControllerDelegate?

    var event: Event? {
        didSet {
            textField.stringValue = ""
            textField.becomeFirstResponder()
            collectionView.reloadData()
        }
    }

    override var preferredContentSize: NSSize {
        set { }
        get {
            return NSSize(width: 600, height: 800)
        }
    }

    lazy var titleLabel: NSTextField = {
        let label = NSTextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isEditable = false
        label.drawsBackground = false
        label.isBordered = false
        label.alignment = .center
        label.font = .systemFont(ofSize: 17)
        label.stringValue = "Event name:"
        return label
    }()

    lazy var textField: NSTextField = {
        let field = NSTextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.delegate = self
        return field
    }()

    lazy var scrollView: NSScrollView = {
        let view = NSScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var submitButton: NSButton = {
        let button = NSButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.keyEquivalent = "\r"
        button.bezelStyle = .rounded
        button.target = self
        button.action = #selector(submit)
        button.isEnabled = false
        return button
    }()

    lazy var collectionView: NSCollectionView = {
        let layout = NSCollectionViewFlowLayout()
        layout.itemSize = NSSize(width: 120, height: 120)
        layout.sectionInset = NSEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
        layout.minimumInteritemSpacing = 20.0
        layout.minimumLineSpacing = 20.0
        layout.scrollDirection = .vertical

        let view = NSCollectionView()
        view.collectionViewLayout = layout
        view.dataSource = self
        view.delegate = self

        view.register(FileItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "item"))
        view.register(CollectionViewHeader.self,
                      forSupplementaryViewOfKind: NSCollectionView.SupplementaryElementKind.sectionHeader,
                      withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "header"))

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(titleLabel)
        view.addSubview(textField)
        view.addSubview(scrollView)
        view.addSubview(submitButton)
        scrollView.documentView = collectionView

        createViewConstraints()
    }

    private func createViewConstraints() {
        let margin: CGFloat = 20

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: margin),

            textField.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: margin),
            textField.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            textField.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),

            submitButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: margin),
            submitButton.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            submitButton.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),

            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: margin),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin)
            ])
    }

    @objc func submit() {
        event?.name = textField.stringValue
        delegate?.eventNamed()
    }

    func show(event: Event, index: Int, total: Int) {
        self.event = event
        submitButton.title = index + 1 < total ? "Next" : "Done"
    }
    
}
