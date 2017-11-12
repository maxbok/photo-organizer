//
//  MainWindowController+DragAndDropViewControllerDelegate.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 02/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Foundation


extension MainWindowController: DragAndDropViewControllerDelegate {

    func processing() {
        guard let eventsWindow = eventsWindowController.window else {
            return
        }

        window?.beginSheet(eventsWindow, completionHandler: nil)
        eventsWindowController.processing()
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
            guard let event = events.first else { return }
            self.eventsWindowController.show(event: event)
        }
    }

    private func notify(progress: [(Int, Int)]) {
        var count = 0
        var total = 0

        progress.forEach { c, t in
            count += c
            total += t
        }

        eventsWindowController.processing(count, of: total)
    }

}
