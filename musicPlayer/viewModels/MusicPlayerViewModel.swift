//
//  MusicPlayerViewModel.swift
//  musicPlayer
//
//  Created by Александр Левин on 31.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

import MediaPlayer

struct MusicPlayerViewModel: MusicPlayerViewModelProtocol {
  var player: AVPlayer!
  var track: TrackProtocol
}
