//
//  RequestError.swift
//  GithubTest
//
//  Created by Gutpinter Norbert on 1/29/23.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case responseError
    case badResponse(statusCode: Int)
}
