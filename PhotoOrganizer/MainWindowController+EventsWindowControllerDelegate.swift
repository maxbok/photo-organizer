//
//  MainWindowController+EventsWindowControllerDelegate.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 27/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Foundation


extension MainWindowController: EventsWindowControllerDelegate {

    func eventsWindowController(_ controller: EventsWindowController, named events: [Event]) {
        let (windowController, progressViewController) = createCopyProgressElements()

        windowController.window?.makeKeyAndOrderFront(nil)
        copyProgressWindowControllers.append(windowController)

        copyHandler.copy(
            events: events,
            with: Settings.shared,
            progress: { count, total in
                guard   let count = count,
                        let total = total
                else {
                    progressViewController.hint = "Preparing for copy…"
                    progressViewController.progress = nil
                    return
                }

                progressViewController.hint = "Copying \(count) of \(total)"
                progressViewController.progress = Double(count) / Double(total)
        }) {
            windowController.close()
            if let index = self.copyProgressWindowControllers.index(of: windowController) {
                self.copyProgressWindowControllers.remove(at: index)
            }
        }
    }

    private func createCopyProgressElements() -> (WindowController, ProgressViewController) {
        let windowController = WindowController()
        let viewController = ProgressViewController()

        windowController.window?.styleMask = [.titled, .miniaturizable]
        windowController.mainViewController = viewController

        return (windowController, viewController)
    }

}
