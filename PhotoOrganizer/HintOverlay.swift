//
//  HintOverlay.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 29/10/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa

class HintOverlay: NSView {

    enum State {
        case none, entered

        var text: String {
            switch self {
            case .none:     return "Drag files or folders"
            case .entered:  return "Drop it!!"
            }
        }
    }

    lazy var label: NSTextField = {
        let label = NSTextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isEditable = false
        label.drawsBackground = false
        label.isBordered = false
        return label
    }()

    override var intrinsicContentSize: NSSize {
        let size = label.intrinsicContentSize
        return CGSize(width: size.width + 12,
                      height: size.height + 6)
    }

    var state: State = .none {
        didSet {
            refresh()
        }
    }

    override var isOpaque: Bool {
        return false
    }

    init() {
        super.init(frame: .zero)

        addSubview(label)

        createConstraints()

        refresh()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }

    override func draw(_ dirtyRect: NSRect) {
        NSColor.gray.withAlphaComponent(0.6).setFill()
        let radius: CGFloat = 6
        let path = NSBezierPath(roundedRect: bounds, xRadius: radius, yRadius: radius)
        path.fill()
    }

    private func refresh() {
        label.stringValue = state.text
        invalidateIntrinsicContentSize()
    }
    
}
