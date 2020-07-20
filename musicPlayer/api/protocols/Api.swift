//
//  Api.swift
//  musicPlayer
//
//  Created by Александр Левин on 19.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

import UIKit

protocol Api {
  func getResult(searchText: String, completion: @escaping (String) -> Void)
  func getImage(url: String, completion: @escaping (Data) -> Void)
}
