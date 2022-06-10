//
//  CoverModel.swift
//  
//
//  Created by Veit Progl on 30.05.22.
//

import Foundation

public struct Cover: Equatable, Decodable {
    public init(smallThumbnail: String, thumbnail: String) {
//        let smallThumbnailSecure = smallThumbnail.replacingOccurrences(of: "http", with: "https")
//        let thumbnailSecure = thumnail.replacingOccurrences(of: "http", with: "https")

//        self.smallThumbnail = URL(string: smallThumbnailSecure) ?? nil
//        self.thumbnail = URL(string: thumbnailSecure) ?? nil
        self.smallThumbnail = smallThumbnail
        self.thumbnail = thumbnail

    }
    public let smallThumbnail, thumbnail: String?
}
