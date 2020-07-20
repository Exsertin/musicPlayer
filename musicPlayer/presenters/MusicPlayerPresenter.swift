//
//  MusicPlayerPresenter.swift
//  musicPlayer
//
//  Created by Александр Левин on 20.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

import MediaPlayer

class MusicPlayerPresenter: MusicPlayerPresenterProtocol {
  var player: AVPlayer!
  
  private var track: TrackProtocol
  private var trackMaxTime: Float
  weak private var viewDelegate: MusicPlayerViewDelegate?
  
  init(track: TrackProtocol) {
    self.track = track
    player = AVPlayer(url: URL(string: track.getTrackPreviewUrl())!)
    trackMaxTime = Float(player.currentItem?.asset.duration.seconds ?? 0).rounded()
  }
  
  func setViewDelegate(viewDelegate: MusicPlayerViewDelegate?) {
    self.viewDelegate = viewDelegate
  }
  
  func viewDidLoadDelegate() {
    guard let delegate = viewDelegate else {
      return
    }
    
    ITunesApiManager(ITunesApi()).loadArtwork(track: track) {
      delegate.setArtworkImage(data: $0)
    }
    
    delegate.setArtistName(text: track.getArtistName())
    delegate.setTrackName(text: track.getTrackName())
    delegate.setCollectionName(text: track.getCollectionName())
    delegate.updateSliderMaxValue(value: trackMaxTime)
    delegate.updateSliderValue(value: 0)
    delegate.updateCurrentTime(str: "0:00")
    delegate.updateEndTime(str: TimeTranslator.translateSecondsToMinutes(seconds: Int(trackMaxTime)))
    addPeriodicToPlayer()
  }
  
  private func addPeriodicToPlayer() {
    guard let delegate = viewDelegate else {
      return
    }
    
    let cmTime = CMTime(seconds: 1, preferredTimescale: 1000)
    player.addPeriodicTimeObserver(forInterval: cmTime, queue: DispatchQueue.main) { time in
      let seconds = time.seconds.rounded()
      delegate.updateCurrentTime(str: TimeTranslator.translateSecondsToMinutes(seconds: Int(seconds)))
      delegate.updateSliderValue(value: Float(time.seconds))
      let maxTime = Int(self.trackMaxTime) - Int(seconds)
      let currentMaxTime = TimeTranslator.translateSecondsToMinutes(seconds: maxTime)
      delegate.updateEndTime(str: "\(currentMaxTime)")
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
      viewDelegate?.setPauseTitle()
      player.play()
    } else {
      viewDelegate?.setPlayTitle()
      player.pause()
    }
  }
  
  func changePlayerTimeLine(value: Float) {
    guard let delegate = viewDelegate else {
      return
    }
    
    player.seek(to: CMTime(seconds: Double(value), preferredTimescale: 1000)) { _ in
      delegate.updateCurrentTime(str: TimeTranslator.translateSecondsToMinutes(seconds: Int(value)))
      let endSeconds = Int(self.trackMaxTime) - Int(value)
      let endTime = TimeTranslator.translateSecondsToMinutes(seconds: endSeconds)
      delegate.updateEndTime(str: endTime)
    }
  }
}
