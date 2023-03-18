import SwiftUI

struct MovieListView: View {
    
    @ObservedObject private var viewModel = MovieListViewModel()
    private let tmdbAPI = TMDbAPI()
    
    var body: some View {
        NavigationView {
            VStack {
                if let movies = viewModel.movies {
                    List {
                        ForEach(movies) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                MovieRow(movie: movie, tmdbAPI: tmdbAPI)
                            }
                        }
                    }
                    .navigationTitle("映画一覧")
                } else {
                    Text("Loading movies...")
                }
            }
            .onAppear(perform: viewModel.fetchMovies)
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
