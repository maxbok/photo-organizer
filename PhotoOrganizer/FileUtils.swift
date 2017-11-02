//
//  FileUtils.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 01/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa

class FileUtils {

    private let manager = FileManager.default

    func filesURLs(from urls: [URL]) -> [URL] {
        var files = [URL]()

        for url in urls {
            content(of: url).forEach { files.append($0) }
        }

        return files
    }

    private func content(of url: URL) -> [URL] {
        var files = [URL]()

        do {
            guard try isDirectory(url: url) else {
                files.append(url)
                return files
            }

            let urls = try manager.contentsOfDirectory(
                at: url,
                includingPropertiesForKeys: [.creationDateKey],
                options: .skipsHiddenFiles)

            for url in urls {

                guard try isDirectory(url: url) else {
                    files.append(url)
                    continue
                }

                content(of: url).forEach { files.append($0) }
            }

            return files
        } catch {
            return []
        }
    }

    private func isDirectory(url: URL) throws -> Bool {
        var isDirectory: ObjCBool = false
        guard manager.fileExists(atPath: url.path, isDirectory: &isDirectory) else {
            throw NSError(description: "\(url) does not exist")
        }

        return isDirectory.boolValue
    }

}
