//
//  Article.swift
//  Breaking News
//
//  Created by Cheryl Chen on 4/21/25.
//

import Foundation

struct NewsFeed: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable, Equatable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

struct Source: Codable, Equatable {
    let id: String?
    let name: String
}

extension Article {
    static var readKey: String {
        return "Read"
    }
    
    static func save(_ articles: [Article], forKey key: String) {
        let defaults = UserDefaults.standard
        let encodeData = try! JSONEncoder().encode(articles)
        defaults.set(encodeData, forKey: key)
    }
    
    static func getArticles(forKey key: String) -> [Article] {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: key) {
            let decodedArticles = try! JSONDecoder().decode([Article].self, from: data)
            return decodedArticles
        } else {
            return []
        }
    }
    
    func addToRead() {
        var readArticles = Article.getArticles(forKey: Article.readKey)
        readArticles.append(self)
        Article.save(readArticles, forKey: Article.readKey)
        print(readArticles)
    }
    
    func removeFromRead() {
        var readArticles = Article.getArticles(forKey: Article.readKey)
        readArticles.removeAll { article in
                return self == article
        }
        Article.save(readArticles, forKey: Article.readKey)
        print(readArticles)
    }
}
