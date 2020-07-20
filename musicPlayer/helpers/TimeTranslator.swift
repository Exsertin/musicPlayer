//
//  TimeTranslator.swift
//  musicPlayer
//
//  Created by Александр Левин on 20.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

class TimeTranslator {
  static func translateSecondsToMinutes(seconds: Int) -> String {
    let oneMinute = 60
    var remainingSeconds = "\(seconds % oneMinute)"
    
    if remainingSeconds.count == 1 {
      remainingSeconds = "0" + remainingSeconds
    }
    
    return "\(seconds / oneMinute):\(remainingSeconds)"
  }
}
