//
//  EventViewController+NSTextFieldDelegate.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 12/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa


extension EventViewController: NSTextFieldDelegate {

    override func controlTextDidChange(_ obj: Notification) {
        submitButton.isEnabled = textField.stringValue.count > 0
    }

}
