import SwiftUI

struct MovieListView: View {
    
    @ObservedObject private var viewModel = MovieListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let movies = viewModel.movies {
                    List {
                        ForEach(movies) { movie in
                            NavigationLink(
                                destination: MovieDetailView(movie: movie),
                                label: {
                                    MovieRow(movie: movie)
                                }
                            )
                        }
                    }
                } else {
                    Text("Loading movies...")
                }
            }
            .navigationTitle("Movies")
            .onAppear(perform: viewModel.fetchMovies)
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
