//
//  ITunesApi.swift
//  musicPlayer
//
//  Created by Александр Левин on 19.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

import Alamofire

class ITunesApi: Api {
  func getResult(searchText: String, completion: @escaping (String) -> Void) {
    Alamofire.request("https://itunes.apple.com/search", method: .get, parameters: ["term": searchText]).responseString { response in
      
      guard response.response?.statusCode == 200, let value = response.result.value else {
        return
      }
      
      completion(value)
    }
  }
  
  func getImage(url: String, completion: @escaping (Data) -> Void) {
    Alamofire.request(url).responseData { response in
      guard response.response?.statusCode == 200, let value = response.result.value else {
        return
      }
      
      completion(value)
    }
  }
}
