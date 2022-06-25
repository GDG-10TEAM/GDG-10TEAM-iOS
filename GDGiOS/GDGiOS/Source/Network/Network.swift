//
//  Network.swift
//  GDGiOS
//
//  Created by 김민창 on 2022/06/25.
//

import Foundation

import Alamofire

enum NetworkError: Error {
    case error(statusCode: Int, data: Data)
    case notConnected
    case unknownError
}

final class DefaultNetworkService {
    static let instance = DefaultNetworkService()
    
    private init() { }
    
    func request<T: Decodable>(
        router: Router, completion: @escaping (T) -> Void
    ) {
        AF.request(
            router.url,
            method: router.method,
            parameters: router.parameters,
            encoding: router.parameterEncoding,
            headers: router.headers
        )
        .validate(statusCode: 200..<500)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success:
                guard let value = response.value else { return }
                completion(value)
            case .failure(let error):
                print(error)
                return
            }
        }
    }
}

