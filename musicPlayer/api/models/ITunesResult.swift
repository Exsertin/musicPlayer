//
//  ITunesResult.swift
//  musicPlayer
//
//  Created by Александр Левин on 19.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

struct ITunesResult: Decodable {
  struct Result: Decodable {
    let typeTrack = "track"
    
    var wrapperType: String
    var artistName: String
    var collectionName: String?
    var trackName: String
    var previewUrl: String?
    var artworkUrl100: String?
    
    func isTrack() -> Bool {
      return wrapperType == typeTrack
    }
  }
  
  var resultCount: Int
  var results: [Result]
}

extension ITunesResult.Result: TrackProtocol {
  func getArtworkPreviewUrl() -> String? {
    return artworkUrl100
  }
  
  func getTrackPreviewUrl() -> String {
     return previewUrl!
   }
  
  func getArtistName() -> String {
    return artistName
  }
  
  func getTrackName() -> String {
    return trackName
  }
  
  func getCollectionName() -> String {
    return collectionName!
  }
}
