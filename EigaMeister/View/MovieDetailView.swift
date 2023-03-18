import SwiftUI

struct MovieDetailView: View {
    @State private var movieDetails: MovieDetails?
    let movie: Movie
    private let tmdbAPI = TMDbAPI()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(movie.title)
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)
                
                if let movieDetails = movieDetails {
                    Text("Overview")
                        .font(.headline)
                    Text(movieDetails.overview)
                    
                    Text("Release Date")
                        .font(.headline)
                    Text(movieDetails.releaseDate)
                    
                    Text("Runtime")
                        .font(.headline)
                    Text("\(movieDetails.runtime) minutes")
                }
            }.padding()
        }.onAppear(perform: loadMovieDetails)
    }

    private func loadMovieDetails() {
        tmdbAPI.fetchMovieDetails(movieId: movie.id) { result in
            switch result {
            case .success(let details):
                movieDetails = details
            case .failure(let error):
                print("Error fetching movie details: \(error)")
            }
        }
    }
}
