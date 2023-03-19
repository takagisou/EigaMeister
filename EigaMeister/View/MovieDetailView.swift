import SwiftUI

struct MovieDetailView: View {
    @State private var movieDetails: MovieDetails?
    let movie: Movie
    private let tmdbAPI = TMDbAPI()

    var body: some View {
        ZStack {
            if let posterPath = movie.posterPath, let imageURL = tmdbAPI.imageURL(for: posterPath) {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .opacity(0.8)
                        .transition(.opacity)
                } placeholder: {
                    ProgressView()
                }
            }

            ScrollView {
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text(movie.overview)
                        .font(.body)
                        .foregroundColor(.white)
                        .padding(.top, 8)

                    Text("Release Date: \(movie.releaseDate ?? "N/A")")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .padding(.top, 8)

                    Text("Rating: \(movie.voteAverage, specifier: "%.1f") / 10")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .padding(.top, 8)

                    Spacer()
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(movie.title)
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

struct MovieDetailView_Previews: PreviewProvider {
    static let movie = Movie(id: 460465, title: "Mortal Kombat", overview: "MMA fighter Cole Young seeks out Earth's greatest champions in order to stand against the enemies of Outworld in a high stakes battle for the universe.", posterPath: "/6Wdl9N6dL0Hi0T1qJLWSz6gMLbd.jpg", backdropPath: "/9yBVqNruk6Ykrwc32qrK2TIE5xw.jpg", releaseDate: "2021-04-07", voteAverage: 7.4)

    static var previews: some View {
        MovieDetailView(movie: movie)
    }
}
