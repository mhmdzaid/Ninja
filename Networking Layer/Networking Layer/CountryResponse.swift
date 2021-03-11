//
//  CountryResponse.swift
//  Networking Layer
//
//  Created by Mohamed Zead on 3/11/21.
//

import Foundation

// MARK: - CountryResponse
struct CountryResponse: Codable {
    let status: Int?
    let message: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let countries: [Country]?
}

// MARK: - Country
struct Country: Codable {
    let id: Int?
    let name: String?
    let image: String?
}

// MARK: - ProfileUploadResponse
struct ProfileUploadResponse: Codable {
    let status: Int?
    let message: String?
    let data: ProfileData?
}

// MARK: - DataClass
struct ProfileData: Codable {
    let user: User?
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let firstName, lastName, phone, email: String?
    let authorization, code: String?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case phone, email, authorization, code, image
    }
}
