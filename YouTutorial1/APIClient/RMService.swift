//
//  RMService.swift
//  YouTutorial1
//
//  Created by Bruce Fraser on 3/8/23.
//

import Foundation

/// Primary API service object to get R&M data
final class RMService {
    static let shared = RMService()
    
    private init() {}
    
    enum RMServiceError: Error {
            case failedToCreateRequest
            case failedToGetData
    }
    /// Send R&M API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - completion: Calleback
    public func execute<T: Codable>(_ request: RMRequest, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return
            }

            // Decode response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
//                self?.cacheManager.setCache(
//                    for: request.endpoint,
//                    url: request.url,
//                    data: data
//                )
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        } 
        task.resume()
    }
    
    // MARK: - Private
        private func request(from rmRequest: RMRequest) -> URLRequest? {
            guard let url = rmRequest.url else {
                return nil
            }
            var request = URLRequest(url: url)
            request.httpMethod = rmRequest.httpMethod
            return request
        }
}
