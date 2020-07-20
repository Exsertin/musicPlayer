//
//  MusicPlayerViewDelegate.swift
//  musicPlayer
//
//  Created by Александр Левин on 20.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

import UIKit

protocol MusicPlayerViewDelegate: class {
  func setArtworkImage(data: Data)
  func setArtistName(text: String)
  func setTrackName(text: String)
  func setCollectionName(text: String)
  func setPlayTitle()
  func setPauseTitle()
}
