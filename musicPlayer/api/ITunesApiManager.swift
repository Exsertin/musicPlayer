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
  
  func findSongs(searchText: String, completion: @escaping ([ITunesResult.Result]) -> Void) {
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
      
      completion(model!.results)
    }
  }
}
