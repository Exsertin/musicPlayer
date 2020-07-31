//
//  MusicPlayerViewModel.swift
//  musicPlayer
//
//  Created by Александр Левин on 31.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

import MediaPlayer
import RxSwift

struct MusicPlayerViewModel: MusicPlayerViewModelProtocol {
  var player: AVPlayer!
  var track: TrackProtocol
  
  func loadArtwork() -> Single<Data> {
    return Single<Data>.create { single in
      ITunesApiManager(ITunesApi()).loadArtwork(track: self.track) {
        single(.success($0))
      }
      
      return Disposables.create()
    }
  }
  
  
  func playPausePlayer() {
    var isPause: Bool = true
    
    if #available(iOS 10.0, *) {
      isPause = player.timeControlStatus == .paused
    } else {
      isPause = player.rate == 0
    }
    
    if isPause {
      player.play()
    } else {
      player.pause()
    }
  }
}
