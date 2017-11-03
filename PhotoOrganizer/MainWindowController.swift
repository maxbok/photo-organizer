//
//  MainWindowController.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 02/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    lazy var dragAndDropViewController: DragAndDropViewController = {
        let controller = DragAndDropViewController()
        controller.delegate = self
        return controller
    }()

    override func windowDidLoad() {
        super.windowDidLoad()

        contentViewController = dragAndDropViewController
    }

}
