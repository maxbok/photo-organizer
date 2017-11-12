//
//  EventViewController+NSCollectionViewDataSource.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 04/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa


extension EventViewController: NSCollectionViewDataSource {

    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return event?.days.count ?? 0
    }

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return event?.days[section].samplesCount ?? 0
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "item"), for: indexPath)

        guard   let fileItem = item as? FileItem,
                let file = event?.days[indexPath.section].sampleFile(at: indexPath.item)
        else {
            return item
        }

        fileItem.file = file
        return fileItem
    }

    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: NSCollectionView.SupplementaryElementKind, at indexPath: IndexPath) -> NSView {
        let supplementaryView = collectionView.makeSupplementaryView(ofKind: kind, withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "header"), for: indexPath)

        guard   let header = supplementaryView as? CollectionViewHeader,
                let day = event?.days[indexPath.section]
        else {
            return supplementaryView
        }

        header.title = "\(day.description) (\(day.files.count) files)"
        return header
    }

}
