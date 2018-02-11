//
//  EventViewController+NSCollectionViewDelegate.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 05/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa
import Quartz


extension EventViewController: NSCollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> NSSize {
        return NSSize(width: collectionView.bounds.width, height: 32)
    }

    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        reloadPreviewPanel()
    }

}
