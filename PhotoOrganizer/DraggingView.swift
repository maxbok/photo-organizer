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

    private let supportedType = kUTTypeFileURL as String

    private lazy var hintOverlay: HintOverlay = {
        let view = HintOverlay()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init() {
        super.init(frame: .zero)

        register(forDraggedTypes: [kUTTypeURL as String])

        addSubview(hintOverlay)

        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createConstraints() {
        NSLayoutConstraint.activate([
            hintOverlay.centerXAnchor.constraint(equalTo: centerXAnchor),
            hintOverlay.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        NSColor.paleBlue.setFill()
        NSRectFill(dirtyRect)
    }

    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        hintOverlay.state = supportedItems(sender).count > 0 ? .entered : .none
        return NSDragOperation.generic
    }

    override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
        hintOverlay.state = supportedItems(sender).count > 0 ? .entered : .none
        return NSDragOperation.generic
    }

    override func draggingExited(_ sender: NSDraggingInfo?) {
        hintOverlay.state = .none
    }

    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        return supportedItems(sender).count > 0
    }

    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        defer {
            hintOverlay.state = .none
        }

        let items = supportedItems(sender)
        guard items.count > 0 else {
            return false
        }

        let paths = items.map { $0.string(forType: supportedType) }.flatMap { $0 }
        let urls = paths.map { URL(string: $0) }.flatMap { $0 }
        delegate?.dragged(urls: urls)

        return true
    }

    private func supportedItems(_ sender: NSDraggingInfo) -> [NSPasteboardItem] {
        guard let items = sender.draggingPasteboard().pasteboardItems else {
            return []
        }

        return items.filter { $0.types.contains(supportedType) }
    }

}
