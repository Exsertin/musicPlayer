//
//  ITunesApiManager.swift
//  musicPlayer
//
//  Created by Александр Левин on 19.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

class ITunesApiManager: ApiManager {
  private var api: Api
  
  init(_ api: Api) {
    self.api = api
  }
  
  func findSongs(searchText: String, completion: @escaping (ITunesResult) -> Void) {
    api.getResult(searchText: searchText) { $0 }
  }
}
