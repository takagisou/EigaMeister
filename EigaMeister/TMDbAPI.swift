import Foundation

struct TMDbAPI {
    private let apiKey = "YOUR_TMDB_API_KEY"
    private let baseURL = "https://api.themoviedb.org/3"
    
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let discoverURL = "\(baseURL)/discover/movie?api_key=\(apiKey)"
        
        guard let url = URL(string: discoverURL) else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(movieResponse.results))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
