//
//  ITunesResult.swift
//  musicPlayer
//
//  Created by Александр Левин on 19.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

struct ITunesResult: Decodable {
  struct Result: Decodable {
    var kind: String
    var artistName: String
    var collectionName: String?
    var trackName: String
    var previewUrl: String?
    var artworkUrl100: String?
  }
  
  var resultCount: Int
  var results: [Result]
}
