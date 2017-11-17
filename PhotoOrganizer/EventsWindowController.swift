//
//  EventsWindowController.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 12/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa

class EventsWindowController: NSWindowController {

    private let container = ViewController()
    private let processingViewController = ProcessingViewController()

    private lazy var eventViewController: EventViewController = {
        let controller = EventViewController()
        controller.delegate = self
        return controller
    }()

    var events = [Event]() {
        didSet {
            eventIndex = 0
        }
    }

    private(set) var eventIndex = 0

    init() {
        super.init(window: NSWindow())

        container.addMainChildViewController(processingViewController)
        contentViewController = container
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Processing

    func processing() {
        if processingViewController.parent == nil {
            container.removeChildren()
            container.addMainChildViewController(processingViewController)
        }
        processingViewController.hint = "Processing…"
        processingViewController.progress = nil
    }

    func processing(_ count: Int, of total: Int) {
        processingViewController.hint = "Processing \(count + 1) of \(total)"
        processingViewController.progress = Double(count + 1) / Double(total)
    }

    // Event

    func show(events: [Event]) {
        self.events = events

        container.removeChildren()
        container.addMainChildViewController(eventViewController)

        showNextEvent()
    }

    func showNextEvent() {
        eventViewController.show(event: events[eventIndex], index: eventIndex, total: events.count)
        eventIndex += 1
    }

    func eventsNamed() {
        processing()

        let eventFormatter = DateFormatter()
        eventFormatter.dateFormat = "yyyyMMdd"

        let eventDayFormatter = DateFormatter()
        eventDayFormatter.dateFormat = "yy-MM-dd"

        let settings = Settings(eventDateFormatter: eventFormatter, eventDayFormatter: eventDayFormatter)

        copyEvents(settings: settings)
    }

    private func copyEvents(settings: Settings) {
        let fileUtils = FileUtils()
        let destinationFolder = settings.outputFolderPath

        var progresses = [Date: (Int, Int)]()

        let completionGroup = DispatchGroup()

        for event in events {
            for day in event.days {
                completionGroup.enter()

                let dayFolder = settings.relativePathToFolder(for: event, on: day)
                fileUtils.copyFiles(
                    at: day.files.map { $0.originalPath },
                    to: "\(destinationFolder)/\(dayFolder)",
                    progress: { count, total in
                        progresses[day.date] = (count, total)
                        self.updateProgress(with: progresses)
                    },
                    completion: {
                        completionGroup.leave()
                    }
                )
            }
        }

        completionGroup.notify(queue: DispatchQueue.main) {
            if let window = self.window {
                window.sheetParent?.endSheet(window)
            }
        }
    }

    private func updateProgress(with progresses: [Date: (Int, Int)]) {
        let (count, total) = progresses.map{ $1 }.reduce((0, 0)) { (result, element) -> (Int, Int) in
            return (result.0 + element.0, result.1 + element.1)
        }

        DispatchQueue.main.async {
            self.processing(count, of: total)
        }
    }

}
