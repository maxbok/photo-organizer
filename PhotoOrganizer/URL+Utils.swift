//
//  URL+Utils.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 01/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Foundation


extension URL {

    var creationDate: Date? {
        let calendar = Calendar.current
        do {
            if let date = try self.resourceValues(forKeys: [.creationDateKey]).creationDate {
                return calendar.startOfDay(for: date)
            }
        } catch {
            print("Error retrieving creation date: \(error)")
        }

        return nil
    }

}
