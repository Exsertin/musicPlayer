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
    Alamofire.request("https://is3-ssl.mzstatic.com/image/thumb/Music123/v4/a4/e3/f3/a4e3f3bf-6d10-b8ef-0056-580b60ca977e/source/100x100bb.jpg").responseData { response in
      guard response.response?.statusCode == 200, let value = response.result.value else {
        return
      }
      
      completion(value)
    }
  }
}
