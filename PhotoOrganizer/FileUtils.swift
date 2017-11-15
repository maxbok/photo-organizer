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

    // MARK: - Read

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

    // MARK: - Copy

    func copyFiles(at paths: [String], to folder: String, progress: @escaping (Int, Int) -> Void, completion: @escaping () -> Void) {
        let folder = (folder as NSString).expandingTildeInPath

        do {
            try manager.createDirectory(
                atPath: folder,
                withIntermediateDirectories: true,
                attributes: nil)
        } catch {
            error.alert()
        }

        let count = paths.count
        for (i, path) in paths.enumerated() {
            progress(i, count)
            let fileName = (path as NSString).lastPathComponent
            let toPath = uniquePath(with: fileName, folder: folder)
            do {
                try manager.copyItem(atPath: path, toPath: toPath)
            } catch {
                error.alert()
            }
        }

        completion()
    }

    func uniquePath(with fileName: String, folder: String) -> String {
        var fileName = fileName
        var path = "\(folder)/\(fileName)"

        let maxCount = 100
        var attempts = 0

        while manager.fileExists(atPath: path) {
            guard attempts < maxCount else { break }

            fileName = increment(fileName: fileName)
            path = "\(folder)/\(fileName)"
            attempts += 1
        }

        return path
    }

    func increment(fileName: String) -> String {
        let ext = (fileName as NSString).pathExtension
        let name = (fileName as NSString).deletingPathExtension
        let separator: Character = " "
        var components = name.split(separator: separator)
        let count = components.count

        guard   count > 1,
                let suffix = Int(components[count - 1])
        else {
            return filename(with: name, suffix: 1, ext: ext)
        }

        components.removeLast()
        return filename(
            with: components.joined(separator: String(separator)),
            suffix: suffix + 1,
            ext: ext)
    }

    private func filename(with name: String, suffix: Int, ext: String) -> String {
        return "\(name) \(suffix).\(ext)"
    }

}
