//
//  EventDay.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 28/10/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa


struct EventDay {

    var files = [File]()
    let date: Date

    init(date: Date) {
        self.date = date
    }

}
