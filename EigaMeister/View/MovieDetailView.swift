import SwiftUI

struct MovieDetailView: View {
    @State private var movieDetails: MovieDetails?
    let movie: Movie
    private let tmdbAPI = TMDbAPI()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let posterPath = movie.posterPath, let imageURL = tmdbAPI.imageURL(for: posterPath) {
                    AsyncImage(url: imageURL) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 200, height: 300)
                    .cornerRadius(10)
                }

                Text("リリース日: \(movie.releaseDate ?? "不明")")
                    .font(.headline)

                Text("評価: \(movie.voteAverage, specifier: "%.1f")")
                    .font(.headline)

                Text("概要")
                    .font(.title2)
                    .bold()

                Text(movie.overview)
                    .font(.body)

                Spacer()
            }
            .padding()
        }
        .navigationTitle(movie.title)
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
