import Foundation

struct MovieDetails: Codable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let runtime: Int

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case releaseDate = "release_date"
        case runtime
    }
}
