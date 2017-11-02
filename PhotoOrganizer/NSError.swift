//
//  NSError.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 01/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Foundation


extension NSError {

    convenience init(description: String) {
        self.init(
            domain: "eu.codehawks.PhotoOrganizer",
            code: -1,
            userInfo: ["description": description])
    }

}
