import Foundation

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
}

struct MovieResponse: Codable {
    let results: [Movie]
}
