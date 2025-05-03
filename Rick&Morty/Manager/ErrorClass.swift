//
//  ErrorClass.swift
//  Rick&Morty
//
//  Created by dhenu on 4/26/25.
//

import Foundation


enum ErrorClass: Error {
    case invalidResponse
    case decodingFailed
    case unknown(Error)
    case serverError
}

