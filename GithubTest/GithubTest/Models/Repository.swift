//
//  Repository.swift
//  GithubTest
//
//  Created by Gutpinter Norbert on 1/29/23.
//

import Foundation

struct RepositorySearch: Decodable, Hashable {
    let totalCount: Int
    let items: [Repository]
}

struct Repository: Decodable, Hashable {
    let id: Int
    let fullName: String
    let htmlUrl: URL
    let description: String?
    let stargazersCount: Int
    let owner: Owner
    let language: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: Repository, rhs: Repository) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Owner: Decodable, Hashable {
    let login: String
    let avatarUrl: URL
}
