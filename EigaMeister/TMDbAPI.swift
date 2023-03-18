import Foundation

struct TMDbAPI {
    private let apiKey: String = {
         if let filePath = Bundle.main.path(forResource: "Config", ofType: "plist"),
            let plist = NSDictionary(contentsOfFile: filePath),
            let apiKey = plist["TMDB_API_KEY"] as? String {
             return apiKey
         } else {
             fatalError("Failed to load API key from Config.plist.")
         }
     }()
    
    private let baseURL = "https://api.themoviedb.org/3"
    private let imageURLBase = "https://image.tmdb.org/t/p/w500"
    
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
                decoder.dateDecodingStrategy = .iso8601
                
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
    
    func fetchMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetails, Error>) -> Void) {
        let movieDetailsURL = "\(baseURL)/movie/\(movieId)?api_key=\(apiKey)"

        guard let url = URL(string: movieDetailsURL) else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601

                do {
                    let movieDetails = try decoder.decode(MovieDetails.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(movieDetails))
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
    
    func imageURL(for path: String) -> URL? {
        return URL(string: imageURLBase + path)
    }
}
