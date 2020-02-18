//
//  ProofOfConceptTests.swift
//  ProofOfConceptTests
//
//  Created by Pradeep Kumar Vadde (Digital) on 13/02/20.
//  Copyright © 2020 Wipro Technologies. All rights reserved.
//

import XCTest

@testable import ProofOfConcept


class ProofOfConceptTests: XCTestCase {
    var imageView : UIImageView? = nil
    
    override func setUp() {
        imageView = UIImageView()
    }
    
    override func tearDown() {
        imageView = nil
    }
    
    func testNetworkStatus() {
        if (NetworkState.isConnected()) {
            XCTAssert(true,"Network is connected")
        } else {
            XCTAssert(false,"Network is not connected")
        }
    }
    
    func testCallToAPICompletes() {
        let url = URL(string: Constants.BASE_URL)
        POCAPIManager.getDataFrom(url: url!) { (success, arrayOFContent, title) in
            if success {
                XCTAssertTrue(true, "success")
            } else {
                XCTFail("failed")
            }
            XCTAssertTrue(title!.isEmpty, "No title available")
            XCTAssertTrue(arrayOFContent!.count > 0, "Data source is available")
        }
    }
    
    func testImageDownloadFromURL() {
        let urlString = "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
        downloadImageFromURL(urlString: urlString)
    }
    
    func downloadImageFromURL( urlString : String?) {
        guard let imageString = urlString else {
            XCTFail("image url not found")
            return
        }
        imageView?.sd_setImage(with: URL(string: imageString)) { (image, error, cacheType, url) in
            if image != nil {
                XCTAssertTrue(true, "successfully image downloaded")
            } else {
                XCTFail("failed to download image")
            }
        }
    }
    
    func testPerformanceExample() {
        let urlString = "https://www.dictionary.com/e/wp-content/uploads/2019/06/1000x700-american-flag-1.jpg"
        self.measure {
            imageView?.sd_setImage(with: URL(string: urlString)) { (image, error, cacheType, url) in
                if error != nil {
                    XCTFail("failed to download image")
                } else {
                    XCTAssertTrue(true, "successfully downloaded image")
                }
                XCTAssertTrue(image != nil, "Image is available")

            }
        }
    }
}
