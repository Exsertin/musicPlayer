//
//  MusicPlayerPresenter.swift
//  musicPlayer
//
//  Created by Александр Левин on 20.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

class MusicPlayerPresenter: MusicPlayerPresenterProtocol {
  private var song: ITunesResult.Result
  private var viewDelegate: MusicPlayerViewDelegate?
  
  init(song: ITunesResult.Result) {
    self.song = song
  }
  
  func setViewDelegate(viewDelegate: MusicPlayerViewDelegate?) {
    self.viewDelegate = viewDelegate
  }
}
