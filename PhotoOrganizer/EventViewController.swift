//
//  EventViewController.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 02/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa

class EventViewController: ViewController {

    let event: Event

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
        return label
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
        button.title = "Submit"
        button.target = self
        button.action = #selector(submit)
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
        view.isHidden = true

        view.register(FileItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "item"))
        view.register(CollectionViewHeader.self,
                      forSupplementaryViewOfKind: NSCollectionView.SupplementaryElementKind.sectionHeader,
                      withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "header"))

        return view
    }()

    init?(event: Event) {
        self.event = event

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(titleLabel)
        view.addSubview(scrollView)
        view.addSubview(submitButton)
        scrollView.documentView = collectionView

        createViewConstraints()

        showEvent()
    }

    private func createViewConstraints() {
        let margin: CGFloat = 20

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: margin),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),

            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            submitButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: margin),
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin)
            ])
    }

    func showEvent() {
        collectionView.reloadData()
        collectionView.isHidden = false
    }

    @objc func submit() {

    }
    
}
