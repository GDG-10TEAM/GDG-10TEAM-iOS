//
//  Router.swift
//  GDGiOS
//
//  Created by 김민창 on 2022/06/25.
//

import Foundation

import Alamofire

protocol Router {
    var path: String { get }
    var url: URL { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var parameterEncoding: ParameterEncoding { get }
    var headers: HTTPHeaders? { get }
}

extension Router {
    var url: URL {
        let urlString = EndPoint.url + path
        print("\n🟡 URL: \(urlString)\n🔴 Method: \(method.rawValue)\n")
        return (try? urlString.asURL())!
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    func headers(_ headers: HTTPMethod) -> HTTPHeaders {
        return HTTPHeaders()
    }
}


//enum ExampleRoutor: Router {
//    case fetchData
//
//    var path: String {
//        switch self {
//        case .fetchData:
//            return "https://api.thecatapi.com/v1/images/search"
//        }
//    }
//
//    var method: HTTPMethod {
//        switch self {
//        case .fetchData:
//            return .get
//        }
//    }
//
//    var parameterEncoding: ParameterEncoding {
//        switch self {
//        case .fetchData:
//            return URLEncoding.default
//        }
//    }
//}
//
//struct ExampleResponseDTO: Codable {
//    let id: String
//    let url: String
//    let width: Int
//    let height: Int
//}
//DefaultNetworkService.instance.request(
//    router: ExampleRoutor.fetchData
//) { [weak self] (response: [ExampleResponseDTO]) in
//    print(response)
//}
