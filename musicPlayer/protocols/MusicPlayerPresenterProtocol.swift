//
//  MusicPlayerPresenterProtocol.swift
//  musicPlayer
//
//  Created by Александр Левин on 20.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

protocol MusicPlayerPresenterProtocol {
  func setViewDelegate(viewDelegate: MusicPlayerViewDelegate?)
  func viewDidLoadDelegate()
  func playPausePlayer()
  func changePlayerTimeLine(value: Float)
}
