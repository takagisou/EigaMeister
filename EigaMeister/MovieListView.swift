import SwiftUI

struct MovieListView: View {
    @State private var movies: [Movie] = []
    private let tmdbAPI = TMDbAPI()
    
    var body: some View {
        List(movies) { movie in
            Text(movie.title)
        }
        .onAppear(perform: loadMovies)
    }
    
    func loadMovies() {
        tmdbAPI.fetchMovies { result in
            switch result {
            case .success(let fetchedMovies):
                movies = fetchedMovies
            case .failure(let error):
                print("Error fetching movies: \(error)")
            }
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
