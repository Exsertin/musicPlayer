//
//  MusicPlayerViewController.swift
//  musicPlayer
//
//  Created by Александр Левин on 20.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class MusicPlayerViewController: UIViewController {
  weak var artworkImageView: UIImageView!
  weak var artistNameLabel: UILabel!
  weak var trackNameLabel: UILabel!
  weak var collectionNameLabel: UILabel!
  weak var slider: UISlider!
  weak var currentTimeLabel: UILabel!
  weak var endTimeLabel: UILabel!
  weak var playPauseButton: UIButton!
  
  let playTitle = "Play"
  let pauseTitle = "Pause"
  
  var viewModel: MusicPlayerViewModelProtocol!
  var disposeBag = DisposeBag()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    genViews()
  }
  
  private func genViews() {
    let image = UIImageView()
    artworkImageView = image
    self.view.addSubview(artworkImageView)
    artworkImageView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(30)
      make.centerX.equalTo(self.view)
      make.size.equalTo(CGSize(width: 100, height: 100))
    }
    
    let lblArtist = UILabel()
    lblArtist.text = "Artist:"
    self.view.addSubview(lblArtist)
    lblArtist.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(self.artworkImageView.snp_bottom).offset(39)
      make.leading.equalTo(self.view).offset(8)
    }
    
    let lblArtistName = UILabel()
    artistNameLabel = lblArtistName
    self.view.addSubview(artistNameLabel)
    artistNameLabel.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(self.artworkImageView.snp_bottom).offset(39)
      make.leading.equalTo(lblArtist.snp_trailing).offset(8)
    }
    
    let lblTrack = UILabel()
    lblTrack.text = "Track:"
    self.view.addSubview(lblTrack)
    lblTrack.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(lblArtist.snp_bottom).offset(10)
      make.leading.equalTo(self.view).offset(8)
    }
    
    let lblTrackName = UILabel()
    trackNameLabel = lblTrackName
    self.view.addSubview(trackNameLabel)
    trackNameLabel.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(self.artistNameLabel.snp_bottom).offset(10)
      make.leading.equalTo(lblTrack.snp_trailing).offset(8)
    }
    
    let lblCollection = UILabel()
    lblCollection.text = "Collection:"
    self.view.addSubview(lblCollection)
    lblCollection.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(lblTrack.snp_bottom).offset(10)
      make.leading.equalTo(self.view).offset(8)
    }
    
    let lblCollectionName = UILabel()
    collectionNameLabel = lblCollectionName
    self.view.addSubview(collectionNameLabel)
    collectionNameLabel.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(self.trackNameLabel.snp_bottom).offset(10)
      make.leading.equalTo(lblCollection.snp_trailing).offset(8)
    }
    
    let btnPlay = UIButton()
    btnPlay.setTitle(playTitle, for: .normal)
    btnPlay.setTitleColor(.blue, for: .normal)
    playPauseButton = btnPlay
    self.view.addSubview(playPauseButton)
    playPauseButton.snp.makeConstraints { (make) -> Void in
      make.centerX.equalTo(self.view)
      make.size.equalTo(CGSize(width: 100, height: 100))
      make.bottom.equalTo(self.bottomLayoutGuide.snp.top).offset(30)
    }
    
    let sldLeftRightOffset = 20
    let sldr = UISlider()
    sldr.addTarget(self, action: #selector(self.sliderValueChangedAction(_:)), for: .valueChanged)
    sldr.maximumValue = viewModel.getSliderMaxValue()
    slider = sldr
    self.view.addSubview(slider)
    slider.snp_makeConstraints { (make) -> Void in
      make.leading.equalTo(self.view).offset(sldLeftRightOffset)
      make.trailing.equalTo(self.view).offset(-sldLeftRightOffset)
      make.bottom.equalTo(self.playPauseButton.snp_top).offset(-40)
    }
    
    let lblCurrentTime = UILabel()
    currentTimeLabel = lblCurrentTime
    self.view.addSubview(currentTimeLabel)
    
    currentTimeLabel.snp.makeConstraints {
      $0.top.equalTo(self.slider.snp_bottom).offset(5)
      $0.leading.equalTo(self.view).offset(sldLeftRightOffset)
    }
    
    let lblEndTime = UILabel()
    endTimeLabel = lblEndTime
    self.view.addSubview(endTimeLabel)
    
    endTimeLabel.snp.makeConstraints {
      $0.top.equalTo(self.slider.snp_bottom).offset(5)
      $0.trailing.equalTo(self.view).offset(-sldLeftRightOffset)
    }
    
    fillLabels()
    initBindings()
  }
  
  func fillLabels() {
    artistNameLabel.text = viewModel.track.getArtistName()
    trackNameLabel.text = viewModel.track.getTrackName()
    collectionNameLabel.text = viewModel.track.getCollectionName()
  }
  
  func initBindings() {
    viewModel.loadArtwork().subscribe(onSuccess: { [weak self] data in
      self?.artworkImageView.image = UIImage(data: data)
    }).disposed(by: disposeBag)
    
    playPauseButton.rx.tap.subscribe(onNext: { [weak self] in
      self?.viewModel.playPausePlayer()
    }).disposed(by: disposeBag)
    
    viewModel.isPlay().subscribe(onNext: { [weak self] isPlay in
      guard let self = self else { return }
      let title = isPlay ? self.pauseTitle : self.playTitle
      self.playPauseButton.setTitle(title, for: .normal)
    }).disposed(by: disposeBag)
    
    viewModel.currentTime.subscribe(onNext: { [weak self] text in
      self?.currentTimeLabel.text = text
    }).disposed(by: disposeBag)
    
    viewModel.endTime.subscribe(onNext: { [weak self] text in
      self?.endTimeLabel.text = text
    }).disposed(by: disposeBag)
    
    viewModel.sliderValue.subscribe(onNext: { [weak self] value in
      self?.slider.value = value
    }).disposed(by: disposeBag)
  }
  
  @objc func sliderValueChangedAction(_ sender: UISlider) {
    viewModel.changePlayerTimeLine(value: sender.value)
  }
}
