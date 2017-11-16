//
//  FocusView.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 16/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa

class FocusView: NSView {

    let cornerRadius: CGFloat
    let lineWidth: CGFloat

    init(cornerRadius: CGFloat, lineWidth: CGFloat) {
        self.cornerRadius = cornerRadius
        self.lineWidth = lineWidth

        super.init(frame: .zero)
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        NSColor.alternateSelectedControlColor.set()

        let rect = NSRect(
            x: lineWidth / 2,
            y: lineWidth / 2,
            width: bounds.width - lineWidth,
            height: bounds.height - lineWidth
        )
        let path = NSBezierPath(roundedRect: rect, xRadius: cornerRadius, yRadius: cornerRadius)
        path.lineWidth = lineWidth
        path.stroke()
    }
    
}
