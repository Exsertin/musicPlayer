//
//  MusicPlayerViewModel.swift
//  musicPlayer
//
//  Created by Александр Левин on 31.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

import MediaPlayer
import RxSwift
import RxRelay

class MusicPlayerViewModel: MusicPlayerViewModelProtocol {
  var player: AVPlayer!
  var track: TrackProtocol
  var currentTime: BehaviorRelay<String>
  var endTime: BehaviorRelay<String>
  
  private var trackMaxTime: Float
  private var isPlayRelay: PublishRelay<Bool> = PublishRelay<Bool>()
  
  init(player: AVPlayer, track: TrackProtocol) {
    self.player = player
    self.track = track
    trackMaxTime = Float(player.currentItem?.asset.duration.seconds ?? 0).rounded()
    currentTime = BehaviorRelay<String>(value: "0:00")
    endTime = BehaviorRelay<String>(value: TimeTranslator.translateSecondsToMinutes(seconds: Int(trackMaxTime)))
  }
  
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
    
    isPlayRelay.accept(isPause)
    isPause ? player.play() : player.pause()
  }
  
  func isPlay() -> PublishRelay<Bool> {
    return isPlayRelay
  }
}
