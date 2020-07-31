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
  var sliderValue: BehaviorRelay<Float>
  var currentTime: BehaviorRelay<String>
  var endTime: BehaviorRelay<String>
  
  private var trackMaxTime: Float
  private var isPlayRelay: PublishRelay<Bool> = PublishRelay<Bool>()
  
  init(player: AVPlayer, track: TrackProtocol) {
    self.player = player
    self.track = track
    trackMaxTime = Float(player.currentItem?.asset.duration.seconds ?? 0).rounded()
    sliderValue = BehaviorRelay<Float>(value: 0)
    currentTime = BehaviorRelay<String>(value: "0:00")
    endTime = BehaviorRelay<String>(value: TimeTranslator.translateSecondsToMinutes(seconds: Int(trackMaxTime)))
    addPeriodicToPlayer()
  }
  
  private func addPeriodicToPlayer() {
    let forInterval = CMTime(seconds: 1, preferredTimescale: 1000)
    player.addPeriodicTimeObserver(forInterval: forInterval, queue: DispatchQueue.main) { [weak self] time in
      
      guard let self = self else {
        return
      }
      
      let seconds = time.seconds.rounded()
      self.currentTime.accept(TimeTranslator.translateSecondsToMinutes(seconds: Int(seconds)))
      self.sliderValue.accept(Float(time.seconds))
      let endSeconds = Int(self.trackMaxTime) - Int(seconds)
      let endTime = TimeTranslator.translateSecondsToMinutes(seconds: endSeconds)
      self.endTime.accept("\(endTime)")
      
      if self.isSliderFinish() {
        self.isPlayRelay.accept(false)
        self.player.seek(to: .zero)
      }
    }
  }
  
  func changePlayerTimeLine(value: Float) {
    player.seek(to: CMTime(seconds: Double(value), preferredTimescale: 1000)) { [weak self] _ in
      guard let self = self else {
        return
      }
      
      self.currentTime.accept(TimeTranslator.translateSecondsToMinutes(seconds: Int(value)))
      let endSeconds = Int(self.trackMaxTime) - Int(value)
      let endTime = TimeTranslator.translateSecondsToMinutes(seconds: endSeconds)
      self.endTime.accept(endTime)
    }
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
  
  func getSliderMaxValue() -> Float {
    return trackMaxTime
  }
  
  private func isSliderFinish() -> Bool {
    return getSliderMaxValue() == sliderValue.value.rounded()
  }
}
