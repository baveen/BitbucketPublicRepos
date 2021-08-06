//
//  DataModels.swift
//  BitbucketPublicRepos
//
//  Created by Baveendran Nagendran on 2021-08-05.
//

import Foundation

struct Repositories: Codable {
    let repos: [PublicRepo]?
    let next: String?
    
    enum CodingKeys: String, CodingKey {
        case repos = "values"
        case next = "next"
    }
       
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        repos = try values.decodeIfPresent([PublicRepo].self, forKey: .repos)
        next = try values.decodeIfPresent(String.self, forKey: .next)
    }
}

struct PublicRepo: Codable {
    let uuid: String?
    let fullName: String?
    let name: String?
    let language: String?
    let type: String?
    let createdOn: String?
    let owner: RepoOwner?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
        case fullName = "full_name"
        case name = "name"
        case language = "language"
        case type = "type"
        case createdOn = "created_on"
        case owner = "owner"
        case description = "description"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        uuid = try values.decodeIfPresent(String.self, forKey: .uuid)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        language = try values.decodeIfPresent(String.self, forKey: .language)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        createdOn = try values.decodeIfPresent(String.self, forKey: .createdOn)
        owner = try values.decodeIfPresent(RepoOwner.self, forKey: .owner)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }
}

struct RepoOwner: Codable {
    let displayName: String?
    let nickName: String?
    let links: Links?
    let accountId: String?
    
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case nickName = "nickname"
        case links = "links"
        case accountId = "account_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        displayName = try values.decodeIfPresent(String.self, forKey: .displayName)
        nickName = try values.decodeIfPresent(String.self, forKey: .nickName)
        links = try values.decodeIfPresent(Links.self, forKey: .links)
        accountId = try values.decodeIfPresent(String.self, forKey: .accountId)
    }
}

struct Links: Codable {
    let selfLink: URLRef?
    let pageLink: URLRef?
    let avatarLink: URLRef?
    
    enum CodingKeys: String, CodingKey {
        case selfLink = "self"
        case pageLink = "html"
        case avatarLink = "avatar"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        selfLink = try values.decodeIfPresent(URLRef.self, forKey: .selfLink)
        pageLink = try values.decodeIfPresent(URLRef.self, forKey: .pageLink)
        avatarLink = try values.decodeIfPresent(URLRef.self, forKey: .avatarLink)
    }
}

struct URLRef: Codable {
    let href: String?
}
