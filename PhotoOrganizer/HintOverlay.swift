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
        label.alignment = .center
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()

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
        let margin: CGFloat = 20

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, constant: -2 * margin),
            label.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor, constant: -2 * margin)
            ])
    }

    override func draw(_ dirtyRect: NSRect) {
        NSColor.black.withAlphaComponent(0.4).setStroke()

        let radius: CGFloat = 44
        let lineWidth: CGFloat = 10
        let rect = CGRect(
            x: lineWidth / 2,
            y: lineWidth / 2,
            width: bounds.width - lineWidth,
            height: bounds.height - lineWidth)
        let path = NSBezierPath(roundedRect: rect, xRadius: radius, yRadius: radius)
        path.lineWidth = lineWidth
        let dash = (bounds.width - lineWidth + 2 * radius) / 18
        path.setLineDash([dash, dash], count: 2, phase: 0)
        path.stroke()
    }

    private func refresh() {
        label.stringValue = state.text
    }
    
}
