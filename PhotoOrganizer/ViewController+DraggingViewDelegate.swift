//
//  ViewController+DraggingViewDelegate.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 31/10/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Foundation


extension ViewController: DraggingViewDelegate {

    func dragged(urls: [URL]) {
        let urls = fileUtils.filesURLs(from: urls)
        let events = Event.from(files: urls)
        
    }

}
