//
//  NSImage+Utils.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 12/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa


extension NSImage {

    func squareResize(to toSize: CGFloat) -> NSImage {
        let destinationSize = NSSize(width: toSize, height: toSize)

        let resizedImage = NSImage(size: destinationSize)
        resizedImage.lockFocus()

        let destinationRect = NSRect(origin: .zero, size: destinationSize)

        let minSide = min(size.width, size.height)
        let fromSize = NSSize(width: minSide, height: minSide)
        let fromOrigin = NSPoint(
            x: (size.width - minSide) / 2,
            y: (size.height - minSide) / 2)
        let fromRect = NSRect(origin: fromOrigin, size: fromSize)
        draw(
            in: destinationRect,
            from: fromRect,
            operation: .sourceOver,
            fraction: 1)

        resizedImage.unlockFocus()
        resizedImage.size = destinationSize
        return resizedImage
    }

}
