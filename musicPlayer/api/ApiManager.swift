//
//  ApiManager.swift
//  musicPlayer
//
//  Created by Александр Левин on 19.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

protocol ApiManager {
  func findSongs(searchText: String, completion: @escaping (ITunesResult) -> Void)
}
