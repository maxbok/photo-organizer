//
//  Date+Utils.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 01/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Foundation


extension Date {

    func sameDay(as date: Date) -> Bool {
        return days(to: date) == 0
    }

    func days(to date: Date) -> Int {
        let calendar = Calendar.current

        let date1 = calendar.startOfDay(for: self)
        let date2 = calendar.startOfDay(for: date)

        let components = calendar.dateComponents([.day], from: date1, to: date2)

        return components.day ?? 0
    }

}
