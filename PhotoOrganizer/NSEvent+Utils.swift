//
//  NSEvent+Utils.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 09/02/2018.
//  Copyright © 2018 Codehawks. All rights reserved.
//

import Cocoa


extension NSEvent {

    var isSpacebarDown: Bool {
        return type == .keyDown && keyCode == 49
    }

    var isArrowDown: Bool {
        return type == .keyDown && 123...126 ~= keyCode
    }

}
