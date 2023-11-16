//
//  PhotoArtifactModel.swift
//  clio-app
//
//  Created by Thiago Henrique on 10/11/23.
//

import Foundation

enum PhotoArtifactModel {
    enum SearchImage {
        struct Request {
            let keywords: String
            let safeSearch: Bool = true
        }
        
        struct Response {
            let id: Int
            let pageURL: String
            let type, tags: String
            let previewURL: String
            let previewWidth, previewHeight: Int
            let webformatURL: String
            let webformatWidth, webformatHeight: Int
            let largeImageURL: String
            let imageWidth, imageHeight, imageSize, views: Int
            let downloads, collections, likes, comments: Int
            let userID: Int
            let user: String
            let userImageURL: String

            enum CodingKeys: String, CodingKey {
                case id, pageURL, type, tags, previewURL, previewWidth, previewHeight, webformatURL, webformatWidth, webformatHeight, largeImageURL, imageWidth, imageHeight, imageSize, views, downloads, collections, likes, comments
                case userID = "user_id"
                case user, userImageURL
            }
        }
    }
}
