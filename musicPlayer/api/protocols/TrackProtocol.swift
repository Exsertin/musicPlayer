//
//  TrackProtocol.swift
//  musicPlayer
//
//  Created by Александр Левин on 20.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

protocol TrackProtocol {
  func getArtworkPreview() -> String?
  func getArtistName() -> String
}