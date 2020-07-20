//
//  ApiManager.swift
//  musicPlayer
//
//  Created by Александр Левин on 19.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

import UIKit

protocol ApiManager {
  func findSongs(searchText: String, completion: @escaping ([ITunesResult.Result]) -> Void)
  func loadArtwork(url: String, completion: @escaping (Data) -> Void)
}
