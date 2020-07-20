//
//  AlertCreator.swift
//  musicPlayer
//
//  Created by Александр Левин on 20.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

import UIKit

class AlertCreator {
 static func notification(message: String) -> UIAlertController {
    let alert = UIAlertController(title: "Notification", message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
    
    return alert
  }
}
