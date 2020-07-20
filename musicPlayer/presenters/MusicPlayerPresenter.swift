//
//  MusicPlayerPresenter.swift
//  musicPlayer
//
//  Created by Александр Левин on 20.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

class MusicPlayerPresenter {
  private var song: ITunesResult.Result
  
  init(song: ITunesResult.Result) {
    self.song = song
  }
}
