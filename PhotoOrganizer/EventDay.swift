//
//  EventDay.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 28/10/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa


class EventDay {

    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()

    var files = [File]()
    let date: Date

    private var sampleIndexes: [Int]?

    var samplesCount: Int {
        return sampleIndexes?.count ?? 0
    }

    var description: String {
        return EventDay.formatter.string(from: date)
    }

    init(date: Date) {
        self.date = date
    }

    func prepareSampleFiles(progress: @escaping (Int, Int) -> Void, completion: @escaping () -> Void) {
        let filesCount = files.count
        let samplesCount = min(filesCount, 5)

        progress(0, samplesCount)

        DispatchQueue.global(qos: .background).async {
            var indexes = [Int]()
            for i in 0..<samplesCount {
                var index: Int
                repeat {
                    index = Int(arc4random_uniform(UInt32(filesCount)))
                } while indexes.contains(index)
                indexes.append(index)

                self.files[index].loadPreview()
                DispatchQueue.main.async {
                    progress(i, samplesCount)
                }
            }

            self.sampleIndexes = indexes

            DispatchQueue.main.async {
                completion()
            }
        }
    }

    func sampleFile(at index: Int) -> File {
        return files[sampleIndexes?[index] ?? 0]
    }

}
