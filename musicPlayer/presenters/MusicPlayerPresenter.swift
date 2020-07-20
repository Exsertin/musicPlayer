//
//  MusicPlayerPresenter.swift
//  musicPlayer
//
//  Created by Александр Левин on 20.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

class MusicPlayerPresenter: MusicPlayerPresenterProtocol {
  private var track: TrackProtocol
  private var viewDelegate: MusicPlayerViewDelegate?
  
  init(track: TrackProtocol) {
    self.track = track
  }
  
  func setViewDelegate(viewDelegate: MusicPlayerViewDelegate?) {
    self.viewDelegate = viewDelegate
  }
}
