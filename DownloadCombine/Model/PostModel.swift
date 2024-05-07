//
//  PostModel.swift
//  DownloadCombine
//
//  Created by Didier Delhaisse on 07/05/2024.
//

import Foundation

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
