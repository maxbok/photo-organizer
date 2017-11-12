//
//  CollectionViewHeader.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 05/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa

class CollectionViewHeader: NSView {

    var title: String? {
        didSet {
            label.stringValue = title ?? ""
        }
    }

    private lazy var label: NSTextField = {
        let label = NSTextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isEditable = false
        label.drawsBackground = false
        label.isBordered = false
        label.alignment = .left
        label.font = .systemFont(ofSize: 17)
        return label
    }()

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        addSubview(label)

        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createConstraints() {
        let margin: CGFloat = 20

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
    
}
