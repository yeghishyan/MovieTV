//
//  APIService.swift
//  DemoApp
//
//  Created by miqo on 08.09.23.
//

import Foundation

typealias ParamType = (name: String, value: String)

struct APIService {
    private let decoder = JSONDecoder()
    static let shared = APIService()
    
    private let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwZTE1YWY1OWJkZmI3YTAzNjFhNmViYjlhNTA1NzVlZCIsInN1YiI6IjY0NThlMjkxNmFhOGUwMDBlNGJjYjc2ZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.L0YItF603rdfj7dqUgTKJA8YiUyHzAjphoDc9JsTGs8"
    let apiKey = "0e15af59bdfb7a0361a6ebb9a50575ed"
    
    
    func buildUrl(endpoint: Endpoint, params: [ParamType]?, baseURL: URL!) async throws -> URL {
        let queryURL = baseURL.appendingPathComponent(endpoint.path())
        guard var components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true) else { throw APIError.invalidEndpoint }
        
        var paramList: [ParamType] = [
            (name: "api_key", value: apiKey)
        ]
        paramList.append(contentsOf: params ?? [])
        components.queryItems = paramList.map { value in
            URLQueryItem(name: value.name, value: value.value)
        }
                
        guard let finalURL = components.url else { throw APIError.invalidEndpoint }
        print("[URL]: [", finalURL, "]")
        return finalURL
    }
    
    func GET<T: Decodable>(url: URL, host: URL!) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else { throw APIError.invalidResponse }
        
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        print("[GET]\t\t", request)
        
        if let responseError = handleResponsesError(response: httpResponse) {
            print(responseError.localizedDescription)
            throw responseError
        }
        
        do {
            let data = try self.decoder.decode(T.self, from: data)
            return data
            
        } catch _ as DecodingError {
            let errorResponse = try self.decoder.decode(ErrorResponse.self, from: data)
            print("[ERROR MESSAGE: \(errorResponse.message)]")
            throw APIError.unknown(errorResponse.message)
        }
    }
    
    private func handleResponsesError(response: HTTPURLResponse) -> APIError? {
        switch response.statusCode {
        case 200: return nil
        case 401: return .unauthorized
        case 503: return .maintenanceApi
        case 500: return .internalError
        default: return .invalidResponse
        }
    }
}
