//
//  Items.swift
//  NOUS
//
//  Created by Mohammad Takbiri on 7/16/22.
//

struct Items: Codable {
    let items: [Item]
}

struct Item: Codable {
    let id: Int
    let title: String
    let description: String
    let imageUrl: String
}
