//
//  JsonApiResponseDecoder.swift
//  musicPlayer
//
//  Created by Александр Левин on 19.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

import UIKit

class JsonApiResponseDecoder<T:Decodable>: ApiResponseDecoder {
  typealias Result = T
  
  func decodeToObject(string jsonString: String) throws -> T? {
    guard let jsonData = jsonString.data(using: .utf8) else {
      return nil
    }
    
    return try getDecoder().decode(T.self, from: jsonData)
  }
  
  private func getDecoder() -> JSONDecoder {
    return JSONDecoder()
  }
}
