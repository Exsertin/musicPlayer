//
//  TrackProtocol.swift
//  musicPlayer
//
//  Created by Александр Левин on 20.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

protocol TrackProtocol {
  func getArtworkPreviewUrl() -> String?
  func getArtistName() -> String
  func getTrackPreviewUrl() -> String?
}
