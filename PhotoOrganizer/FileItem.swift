//
//  FileItem.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 04/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa


class FileItem: NSCollectionViewItem {

    var file: File? {
        didSet {
            guard let file = file else { return }
            imageView?.image = file.preview ?? NSImage(contentsOfFile: file.originalPath)
        }
    }

    override var acceptsFirstResponder: Bool {
        return true
    }

    override var isSelected: Bool {
        didSet {
            focusView.isHidden = !isSelected
        }
    }

    private lazy var focusView: NSView = {
        let view = FocusView(cornerRadius: 8, lineWidth: 4)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()

    override func loadView() {
        view = NSView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = NSImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.wantsLayer = true
        imageView.layer?.cornerRadius = 6
        imageView.layer?.masksToBounds = true
        view.addSubview(imageView)
        self.imageView = imageView

        view.addSubview(focusView)

        createViewConstraints()
    }

    private func createViewConstraints() {
        guard let imageView = imageView else { return }

        let margin: CGFloat = 4

        NSLayoutConstraint.activate([
            focusView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            focusView.topAnchor.constraint(equalTo: view.topAnchor),
            focusView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            focusView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: margin),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin)
            ])
    }

}
