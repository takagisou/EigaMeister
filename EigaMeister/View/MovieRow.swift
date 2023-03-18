import SwiftUI

struct MovieRow: View {
    
    let movie: Movie
    let tmdbAPI: TMDbAPI

    var body: some View {
        HStack {
            if let posterPath = movie.posterPath, let imageURL = tmdbAPI.imageURL(for: posterPath) {
                AsyncImage(url: imageURL) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 150)
                .cornerRadius(10)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(movie.title)
                    .font(.headline)
                Text(movie.releaseDate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}
