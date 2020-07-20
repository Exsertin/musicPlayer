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
  weak private var viewDelegate: MusicPlayerViewDelegate?
  
  init(track: TrackProtocol) {
    self.track = track
    player = AVPlayer(url: URL(string: track.getTrackPreviewUrl())!)
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
}
