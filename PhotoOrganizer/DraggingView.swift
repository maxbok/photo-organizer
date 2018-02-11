//
//  DraggingView.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 29/10/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa

class DraggingView: NSView {

    weak var delegate: DraggingViewDelegate?

    var isEnabled = true {
        didSet {
            setNeedsDisplay(bounds)
        }
    }

    private let supportedType = kUTTypeFileURL as String

    private lazy var hintOverlay: HintOverlay = {
        let view = HintOverlay()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init() {
        super.init(frame: .zero)

        registerForDraggedTypes([NSPasteboard.PasteboardType(rawValue: kUTTypeURL as String as String)])

        addSubview(hintOverlay)

        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createConstraints() {
        let multiplier: CGFloat = 0.6

        NSLayoutConstraint.activate([
            hintOverlay.centerXAnchor.constraint(equalTo: centerXAnchor),
            hintOverlay.centerYAnchor.constraint(equalTo: centerYAnchor),
            hintOverlay.widthAnchor.constraint(equalTo: widthAnchor, multiplier: multiplier),
            hintOverlay.heightAnchor.constraint(equalTo: heightAnchor, multiplier: multiplier)
            ])
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        if isEnabled {
            NSColor.paleBlue.setFill()
        } else {
            NSColor.gray.setFill()
        }
        dirtyRect.fill()
    }

    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        guard isEnabled else { return .generic }
        hintOverlay.state = supportedItems(sender).count > 0 ? .entered : .none
        return .generic
    }

    override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
        guard isEnabled else { return .generic }
        hintOverlay.state = supportedItems(sender).count > 0 ? .entered : .none
        return .generic
    }

    override func draggingExited(_ sender: NSDraggingInfo?) {
        guard isEnabled else { return }
        hintOverlay.state = .none
    }

    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        guard isEnabled else { return false }
        return supportedItems(sender).count > 0
    }

    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        defer {
            hintOverlay.state = .none
        }

        let items = supportedItems(sender)
        guard   isEnabled,
                items.count > 0
        else {
            return false
        }

        let paths = items.map { $0.string(forType: NSPasteboard.PasteboardType(rawValue: supportedType)) }.flatMap { $0 }
        let urls = paths.map { URL(string: $0) }.flatMap { $0 }
        delegate?.dragged(urls: urls)

        return true
    }

    private func supportedItems(_ sender: NSDraggingInfo) -> [NSPasteboardItem] {
        guard let items = sender.draggingPasteboard().pasteboardItems else {
            return []
        }

        return items.filter { $0.types.contains(NSPasteboard.PasteboardType(rawValue: supportedType)) }
    }

}
