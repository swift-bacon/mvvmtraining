//
//  Model.swift
//  mvvmtraining
//
//  Created by Unit27 on 07/08/2025.
//

import Foundation

struct UsersResponse: Codable {
    let data: [PersonResponse]
}

struct PersonResponse: Codable {
    let email: String
    let firstName: String
    let lastName: String
}

//"id": 0,
//      "email": "string",
//      "first_name": "string",
//      "last_name": "string",
//      "avatar": "string"
