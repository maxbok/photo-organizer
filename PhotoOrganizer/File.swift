//
//  File.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 28/10/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa

class File {

    private let previewExtensionsToSkip = ["CR2", "NEF"]

    var originalPath: String
    var preview: NSImage?

    var name: String {
        return (originalPath as NSString).lastPathComponent
    }

    var isPreviewSupported: Bool {
        let ext = (originalPath as NSString).pathExtension.lowercased()
        return !previewExtensionsToSkip.map{ $0.lowercased() }.contains(ext)
    }

    init(originalPath: String) {
        self.originalPath = originalPath
    }

    func loadPreview() {
        preview = NSImage(contentsOfFile: originalPath)?.squareResize(to: 200)
    }

}
