//
//  DragAndDropViewControllerDelegate.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 02/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Foundation


protocol DragAndDropViewControllerDelegate: class {

    func found(events: [Event])

}
