//
//  MusicPlayerViewController.swift
//  musicPlayer
//
//  Created by Александр Левин on 20.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

import UIKit

class MusicPlayerViewController: UIViewController {
  @IBOutlet weak var artworkImageView: UIImageView!
  @IBOutlet weak var artistNameLabel: UILabel!
  @IBOutlet weak var trackNameLabel: UILabel!
  @IBOutlet weak var collectionNameLabel: UILabel!
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var currentTimeLabel: UILabel!
  @IBOutlet weak var endTimeLabel: UILabel!
  
  
  var presenter: MusicPlayerPresenterProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.setViewDelegate(viewDelegate: self)
  }
  
  @IBAction func playPauseAction(_ sender: UIButton) {
  }
}

extension MusicPlayerViewController: MusicPlayerViewDelegate {
  func setArtworkImage(data: Data) {
    artworkImageView.image = UIImage(data: data)
  }
  
  func setArtistName(text: String) {
    artistNameLabel.text = text
  }
  
  func setTrackName(text: String) {
    trackNameLabel.text = text
  }
  
  func setCollectionName(text: String) {
    collectionNameLabel.text = text
  }
}
