//
//  Error+Utils.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 14/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa


extension Error {

    func alert() {
        DispatchQueue.main.async {
            let alert = NSAlert()
            alert.messageText = "Error"
            alert.informativeText = self.localizedDescription
            alert.alertStyle = .warning
            alert.addButton(withTitle: "OK")
            alert.runModal()
        }
    }

}
