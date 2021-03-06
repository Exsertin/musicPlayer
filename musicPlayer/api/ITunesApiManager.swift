//
//  ITunesApiManager.swift
//  musicPlayer
//
//  Created by Александр Левин on 19.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

import UIKit

class ITunesApiManager: ApiManager {
  private var api: Api
  
  required init(_ api: Api) {
    self.api = api
  }
  
  func findTracks(searchText: String, completion: @escaping ([ITunesResult.Result]) -> Void) {
    api.getResult(searchText: searchText) {
      let decoder = JsonApiResponseDecoder<ITunesResult>()
      let model: ITunesResult?
      
      do{
        model = try decoder.decodeToObject(string: $0)
      } catch let error {
        print("ERROR JSON")
        print(error)
        return
      }
      
      completion(model!.results.filter {$0.isTrack() && $0.isTrackValid()})
    }
  }
  
  func loadArtwork(track: TrackProtocol, completion: @escaping (Data) -> Void) {
    guard let url = track.getArtworkPreviewUrl() else {
      return
    }
    
    api.getImage(url: url) {
      completion($0)
    }
  }
}
