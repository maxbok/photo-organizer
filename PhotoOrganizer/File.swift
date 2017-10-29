//
//  File.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 28/10/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa

struct File {

    var originalPath: String
    var preview: NSImage?

    var name: String {
        return (originalPath as NSString).lastPathComponent
    }

    init(originalPath: String) {
        self.originalPath = originalPath
    }

}
