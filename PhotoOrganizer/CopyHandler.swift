//
//  CopyHandler.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 11/02/2018.
//  Copyright © 2018 Codehawks. All rights reserved.
//

import Cocoa

class CopyHandler {

    func copy(events: [Event], with settings: Settings, progress: @escaping (Int, Int) -> Void, completion: @escaping () -> Void) {
        progress(0, 0)

        let fileUtils = FileUtils()
        let destinationFolder = settings.outputFolderPath

        var progresses = [Date: (Int, Int)]()

        let group = DispatchGroup()

        for event in events {
            for day in event.days {
                group.enter()

                let dayFolder = settings.relativePathToFolder(for: event, on: day)
                fileUtils.copyFiles(
                    at: day.files.map { $0.originalPath },
                    to: "\(destinationFolder)/\(dayFolder)",
                    progress: { count, total in
                        progresses[day.date] = (count, total)
                        self.updateProgress(with: progresses, progressBlock: progress)
                    },
                    completion: {
                        group.leave()
                    }
                )
            }
        }

        group.notify(queue: DispatchQueue.main) {
            completion()
        }

    }

    private func updateProgress(with progresses: [Date: (Int, Int)], progressBlock: @escaping (Int, Int) -> Void) {
        let (count, total) = progresses.map{ $1 }.reduce((0, 0)) { (result, element) -> (Int, Int) in
            return (result.0 + element.0, result.1 + element.1)
        }

        DispatchQueue.main.async {
            progressBlock(count, total)
        }
    }

}
