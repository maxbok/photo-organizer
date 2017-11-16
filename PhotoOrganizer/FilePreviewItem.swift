//
//  FilePreviewItem.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 16/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa
import Quartz


class FilePreviewItem: NSObject, QLPreviewItem {

    var previewItemURL: URL!

    init(path: String) {
        previewItemURL = URL(string: path)!
    }

}
