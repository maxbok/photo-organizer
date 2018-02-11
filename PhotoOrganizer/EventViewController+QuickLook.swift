//
//  EventViewController+QuickLook.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 16/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa
import Quartz


extension EventViewController: KeyEventCollectionViewDelegate, QLPreviewPanelDataSource, QLPreviewPanelDelegate {

    func keyEventCollectionViewDidPressSpacebar(_ collectionView: NSCollectionView) {
        showPreviewPanel()
    }

    func showPreviewPanel() {
        guard   collectionView.selectionIndexPaths.count > 0,
                let panel = QLPreviewPanel.shared()
        else {
            return
        }

        panel.makeKeyAndOrderFront(self)
        reloadPreviewPanel()
    }

    func reloadPreviewPanel() {
        guard   QLPreviewPanel.sharedPreviewPanelExists(),
                let panel = QLPreviewPanel.shared(),
                panel.isVisible
        else {
            return
        }

        panel.reloadData()
    }

    override func acceptsPreviewPanelControl(_ panel: QLPreviewPanel!) -> Bool {
        return true
    }

    override func beginPreviewPanelControl(_ panel: QLPreviewPanel!) {
        panel.dataSource = self
        panel.delegate = self
    }

    override func endPreviewPanelControl(_ panel: QLPreviewPanel!) {
        panel.dataSource = nil
        panel.delegate = nil
    }

    // MARK: - QLPreviewPanelDataSource

    func numberOfPreviewItems(in panel: QLPreviewPanel!) -> Int {
        return collectionView.selectionIndexPaths.count
    }

    func previewPanel(_ panel: QLPreviewPanel!, previewItemAt index: Int) -> QLPreviewItem! {
        guard   let indexPath = collectionView.selectionIndexPaths.first,
                let path = file(at: indexPath)?.originalPath
        else {
            return nil
        }

        var components = URLComponents()
        components.scheme = "file"
        components.path = path

        guard let url = components.url else { return nil }

        return url as QLPreviewItem!
    }

    // MARK: - QLPreviewPanelDelegate

    func previewPanel(_ panel: QLPreviewPanel!, handle event: NSEvent!) -> Bool {
        // arrows
        guard event.isArrowDown else { return false }

        collectionView.keyDown(with: event)
        return true
    }

}
