//
//  MusicPlayerViewModelProtocol.swift
//  musicPlayer
//
//  Created by Александр Левин on 31.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

import RxSwift
import RxRelay

protocol MusicPlayerViewModelProtocol {
  var track: TrackProtocol { get }
  var sliderValue: BehaviorRelay<Float> { get }
  var currentTime: BehaviorRelay<String> { get }
  var endTime: BehaviorRelay<String> { get }
  
  func changePlayerTimeLine(value: Float)
  func playPausePlayer()
  func loadArtwork() -> Single<Data>
  func isPlay() -> PublishRelay<Bool>
  func getSliderMaxValue() -> Float
}
