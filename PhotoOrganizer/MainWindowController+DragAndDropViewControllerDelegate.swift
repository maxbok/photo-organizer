//
//  MainWindowController+DragAndDropViewControllerDelegate.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 02/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa


extension MainWindowController: DragAndDropViewControllerDelegate {

    func processing() {
        processingViewController.hint = "Processing…"
        processingViewController.progress = nil

        guard   let processingWindow = processingWindowController.window,
                processingWindow.sheetParent == nil
        else {
            return
        }

        window?.beginSheet(processingWindow, completionHandler: nil)
    }

    func found(events: [Event]) {
        let group = DispatchGroup()

        var progresses = [Date: (Int, Int)]()

        for event in events {
            for day in event.days {
                group.enter()
                day.prepareSampleFiles(
                    progress: { [weak self] count, total in
                        progresses[day.date] = (count, total)
                        self?.notify(progress: Array(progresses.values))
                    },
                    completion: {
                        group.leave()
                    }
                )
            }
        }

        group.notify(queue: DispatchQueue.main) {
            self.dragAndDropViewController.state = .ready
            if let processingWindow = self.processingWindowController.window {
                self.window?.endSheet(processingWindow)
            }
            let controller = EventsWindowController()
            controller.delegate = self
            controller.showWindow(self)
            controller.show(events: events)
            self.eventsWindowControllers.append(controller)
        }
    }

    private func notify(progress: [(Int, Int)]) {
        var count = 0
        var total = 0

        progress.forEach { c, t in
            count += c
            total += t
        }

        processing(count, of: total)
    }

}
