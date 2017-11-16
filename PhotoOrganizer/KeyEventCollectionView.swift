//
//  KeyEventCollectionView.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 16/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa
import Quartz


protocol KeyEventCollectionViewDelegate: class {

    func keyEventCollectionViewKeyDown(with event: NSEvent)

}


class KeyEventCollectionView: NSCollectionView {

    weak var keyDelegate: KeyEventCollectionViewDelegate?

    override func keyDown(with event: NSEvent) {
        keyDelegate?.keyEventCollectionViewKeyDown(with: event)
    }
    
}
