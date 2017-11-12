//
//  NSImage+Utils.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 12/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa


extension NSImage {

    func resize(to toSize: NSSize) -> NSImage {
        let ratio = min(toSize.width / size.width, toSize.height / size.height)

        let destinationSize = NSSize(
            width: ratio * size.width,
            height: ratio * size.height)

        let resizedImage = NSImage(size: destinationSize)
        resizedImage.lockFocus()

        let destinationRect = NSRect(origin: .zero, size: destinationSize)

        draw(
            in: destinationRect,
            from: NSRect(origin: .zero, size: size),
            operation: .sourceOver,
            fraction: 1)

        resizedImage.unlockFocus()
        resizedImage.size = destinationSize
        return resizedImage
    }

}
