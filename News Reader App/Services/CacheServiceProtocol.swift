//
//  CacheServiceProtocol.swift
//  News Reader App
//
//  Created by Apple  on 16/04/2026.
//


//  ArticleCacheService.swift
//  News Reader App

import Foundation

protocol CacheServiceProtocol {
    func saveArticles(_ articles: [Article])
    func loadArticles() -> [Article]?
    func clearCache()
}

final class ArticleCacheService: CacheServiceProtocol {

    // MARK: - Constants
    private enum Keys {
        static let cachedArticles = "cached_articles"
        static let cacheTimestamp = "cache_timestamp"
    }

    private let cacheExpirySeconds: TimeInterval
    private let userDefaults: UserDefaults

    // MARK: - Init
    init(
        userDefaults: UserDefaults = .standard,
        cacheExpirySeconds: TimeInterval = 3600 // 1 hour default
    ) {
        self.userDefaults = userDefaults
        self.cacheExpirySeconds = cacheExpirySeconds
    }

    // MARK: - Save
    func saveArticles(_ articles: [Article]) {
        do {
            let encoded = try JSONEncoder().encode(articles)
            userDefaults.set(encoded, forKey: Keys.cachedArticles)
            userDefaults.set(Date().timeIntervalSince1970, forKey: Keys.cacheTimestamp)
        } catch {
            print("Cache save error: \(error.localizedDescription)")
        }
    }

    // MARK: - Load
    func loadArticles() -> [Article]? {
        // Optional: check expiry
        if isCacheExpired() { return nil }

        guard let data = userDefaults.data(forKey: Keys.cachedArticles) else {
            return nil
        }
        do {
            return try JSONDecoder().decode([Article].self, from: data)
        } catch {
            print("Cache load error: \(error.localizedDescription)")
            return nil
        }
    }

    // MARK: - Clear
    func clearCache() {
        userDefaults.removeObject(forKey: Keys.cachedArticles)
        userDefaults.removeObject(forKey: Keys.cacheTimestamp)
    }

    // MARK: - Expiry Check
    var isCacheExpired: () -> Bool = { false }
    // Override in init if you want expiry logic:
    // private func isCacheExpired() -> Bool {
    //     let timestamp = userDefaults.double(forKey: Keys.cacheTimestamp)
    //     return Date().timeIntervalSince1970 - timestamp > cacheExpirySeconds
    // }
}