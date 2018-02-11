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

    func keyEventCollectionViewDidPressSpacebar(_ collectionView: NSCollectionView)

}


class KeyEventCollectionView: NSCollectionView {

    weak var keyDelegate: KeyEventCollectionViewDelegate?

    override func keyDown(with event: NSEvent) {
        guard !event.isSpacebarDown else {
            keyDelegate?.keyEventCollectionViewDidPressSpacebar(self)
            return
        }

        guard dataSource?.numberOfSections?(in: self) ?? 0 > 0 else {
            super.keyDown(with: event)
            return
        }

        let currentIndexPath = selectionIndexPaths.first
        var indexPath: IndexPath?

        if event.keyCode == 124 {
            indexPath = nextIndexPath(from: currentIndexPath)
        }

        if event.keyCode == 123 {
            indexPath = previousIndexPath(from: currentIndexPath)
        }

        guard let indexPathToSelect = indexPath else {
            super.keyDown(with: event)
            return
        }

        if let current = currentIndexPath {
            deselectItems(at: [current])
        }

        let indexPaths: Set<IndexPath> = [indexPathToSelect]
        selectItems(at: indexPaths, scrollPosition: .nearestHorizontalEdge)
        delegate?.collectionView?(self, didSelectItemsAt: indexPaths)
    }

    private func previousIndexPath(from current: IndexPath?) -> IndexPath? {
        guard let sectionsCount = dataSource?.numberOfSections?(in: self) else { return nil }

        guard let current = current else {
            guard let itemsCount = dataSource?.collectionView(self, numberOfItemsInSection: sectionsCount - 1) else {
                return nil
            }

            return IndexPath(item: itemsCount - 1, section: sectionsCount - 1)
        }

        if current.item > 0 {
            return IndexPath(item: current.item - 1, section: current.section)
        }

        var section = current.section - 1
        if section < 0 {
            section += sectionsCount
        }
        guard let itemsCount = dataSource?.collectionView(self, numberOfItemsInSection: section) else {
            return nil
        }
        return IndexPath(item: itemsCount - 1, section: section)
    }

    private func nextIndexPath(from current: IndexPath?) -> IndexPath? {
        guard let current = current else {
            return IndexPath(item: 0, section: 0)
        }

        guard let itemsCount = dataSource?.collectionView(self, numberOfItemsInSection: current.section) else {
            return nil
        }

        if itemsCount > current.item + 1 {
            return IndexPath(item: current.item + 1, section: current.section)
        }

        guard let sectionsCount = dataSource?.numberOfSections?(in: self) else { return nil }

        return IndexPath(item: 0, section: (current.section + 1) % sectionsCount)
    }

}
