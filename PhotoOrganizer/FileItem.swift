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

    override func loadView() {
        view = NSView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = NSImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        self.imageView = imageView

        createViewConstraints()
    }

    private func createViewConstraints() {
        guard let imageView = imageView else { return }

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }

}
