//
//  ResourceModel.swift
//  Gemini
//
//  Created by shoheiyokoyama on 2017/07/02.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

enum Resource {
    case image
    case movie
}

extension Resource {
    var images: [UIImage] {
        return resourceNames.flatMap { UIImage(named: $0) }
    }

    var urls: [URL] {
        return resourceNames.flatMap { URL(string: $0) }
    }

    private var resourceNames: [String] {
        switch self {
        case .image:
            return ["building", "food", "japan", "minions", "nature", "people"]
        case .movie:
            return ["https://yt-dash-mse-test.commondatastorage.googleapis.com/media/car-20120827-85.mp4",
                    "https://yt-dash-mse-test.commondatastorage.googleapis.com/media/motion-20120802-85.mp4",
                    "https://yt-dash-mse-test.commondatastorage.googleapis.com/media/oops-20120802-85.mp4"]
        }
    }
}
