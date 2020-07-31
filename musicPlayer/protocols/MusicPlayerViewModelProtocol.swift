//
//  MusicPlayerViewModelProtocol.swift
//  musicPlayer
//
//  Created by Александр Левин on 31.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

import RxSwift

protocol MusicPlayerViewModelProtocol {
  var track: TrackProtocol { get }
  
  func playPausePlayer()
  func loadArtwork() -> Single<Data>
}
