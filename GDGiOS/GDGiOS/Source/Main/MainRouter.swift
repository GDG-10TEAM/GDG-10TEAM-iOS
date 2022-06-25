//
//  MainRouter.swift
//  GDGiOS
//
//  Created by 김민창 on 2022/06/26.
//

import Foundation

import Alamofire

enum MainRoutor: Router {
    case mainFetch

    var path: String {
        switch self {
        case .mainFetch:
            return "/userTask/1"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .mainFetch:
            return .get
        }
    }

    var parameterEncoding: ParameterEncoding {
        switch self {
        case .mainFetch:
            return URLEncoding.default
        }
    }
}
