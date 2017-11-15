//
//  FileUtilsTests.swift
//  PhotoOrganizerTests
//
//  Created by Maxime Bokobza on 14/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import XCTest
@testable import PhotoOrganizer


class FileUtilsTests: XCTestCase {

    func testIncrementFileName() {
        let fileUtils = FileUtils()
        let fileNames = [
            "image.jpg": "image 1.jpg",
            "image 1.jpg": "image 2.jpg",
            "image test.jpg": "image test 1.jpg"
            ]

        for (fileName, expectedFileName) in fileNames {
            XCTAssertEqual(fileUtils.increment(fileName: fileName), expectedFileName)
        }
    }

}
