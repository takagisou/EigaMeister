import Foundation

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
}

struct MovieResponse: Codable {
    let results: [Movie]
}
