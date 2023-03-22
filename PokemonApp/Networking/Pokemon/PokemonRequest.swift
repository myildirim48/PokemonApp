//
//  PokemonRequest.swift
//  PokemonApp
//
//  Created by YILDIRIM on 21.03.2023.
//

import Foundation

protocol Request {
    associatedtype RequestDataType
    associatedtype ResponseDataType
    func composeRequest(with data: RequestDataType) throws -> URLRequest
    func parse(data:Data?) throws -> ResponseDataType
}

struct PokemonRequest<A:Codable>: Request {
    
    typealias ResponseDataType = A
    
    enum Path {
        case base
        case detail(String)
        var string: String {
            switch self {
            case .base: return "/api/v2/pokemon/"
            case .detail(let name): return "/api/v2/pokemon/\(name)"
            }
        }
    }
    
    let baseURL: URL
    let path: Path
    
    init(_ baseURL: URL ,path: Path) {
        self.baseURL = baseURL
        self.path = path
    }
    
    func composeRequest(with paramaters: [Query] = []) throws -> URLRequest {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        components.path = path.string
        components.queryItems = paramaters.toItems()
        return URLRequest(url: components.url!)
    }
    
    func parse(data: Data?) throws -> ResponseDataType {
        return try JSONDecoder().decode(ResponseDataType.self, from: data!)
    }
}
