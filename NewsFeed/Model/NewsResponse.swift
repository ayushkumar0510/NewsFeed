//
//  NewsResponse.swift
//  NewsFeed
//
//  Created by Ayush on 30/05/21.
//

import Foundation

// MARK: - NewsResponse
struct NewsResponse: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case totalResults = "totalResults"
        case articles = "articles"
    }
}

// MARK: - Article
struct Article: Codable {
    var source: Source?
    var author: String?
    var title: String?
    var articleDescription: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?

    enum CodingKeys: String, CodingKey {
        case source = "source"
        case author = "author"
        case title = "title"
        case articleDescription = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
        case content = "content"
    }
}

// MARK: - Source
struct Source: Codable {
    var id: String?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
