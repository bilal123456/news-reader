NY Times Most Popular Articles — iOS App
An iOS application that displays the most viewed articles from the NY Times Most Popular API. Users can browse articles, view details, search content, and bookmark articles for offline access.
Built using Swift, UIKit, and MVVM architecture, with a strong focus on clean code, offline support, and testability.

Features

Fetch most viewed articles from the NY Times API
Article listing screen (Home)
Detailed article view
Real-time search functionality
Bookmark articles for offline access
Offline-first caching with automatic fallback when API fails or device is offline
Network connectivity handling
Loading, empty, and error state management

API Integration
The app uses the NY Times Most Popular Articles API:
https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=YOUR_API_KEY

The API key is managed via an environment configuration file and is not hardcoded.

Networking

Generic API requests via URLSession
JSON parsing with Decodable
Centralized APIService layer


Offline Support
The app follows an offline-first approach.
On successful API response: articles are saved to local cache.
On API failure or no internet: cached articles are loaded automatically.
Cache expires after 1 hour by default. Articles are encoded using JSONEncoder and stored in UserDefaults.



Requirements

iOS 15+
Xcode 14+
Swift 5.7+
