import SwiftUI
import Combine

class MovieListViewModel: ObservableObject {
    @Published private(set) var movies: [Movie]?
    private let tmdbAPI = TMDbAPI()
    private var cancellables = Set<AnyCancellable>()

    func fetchMovies() {
        tmdbAPI.fetchMovies { result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self.movies = movies
                }
            case .failure(let error):
                print("Error fetching movies: \(error)")
            }
        }
    }
}
