//
//  SearchTableViewController.swift
//  musicPlayer
//
//  Created by Александр Левин on 19.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

import UIKit
import MediaPlayer

class SearchTableViewController: UITableViewController {
  @IBOutlet var searchBar: UISearchBar!
  
  let segueMusicPlayerId: String = "showMusicPlayer"
  
  var tracks: [TrackProtocol] = []
  
  private var activityIndicator: UIActivityIndicatorView!
  private var player: AVPlayer?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
    viewDidLoadActivityIndicator()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    player?.pause()
    
    guard let indexPath = self.tableView.indexPathForSelectedRow else {
      return
    }
    
    self.tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
  }
  
  func viewDidLoadActivityIndicator() {
    activityIndicator = UIActivityIndicatorView()
    activityIndicator.color = .red
    self.tableView.addSubview(activityIndicator)
    activityIndicator.center = self.tableView.center
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tracks.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
    let track = tracks[indexPath.row]
    cell.textLabel?.text = "\(track.getArtistName()) - \(track.getTrackName())"
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: segueMusicPlayerId, sender: indexPath)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case segueMusicPlayerId:
      guard let destination = segue.destination as? MusicPlayerViewController else {
        return
      }
      
      guard let indexPath = sender as? IndexPath else {
        return
      }
      
      let track = tracks[indexPath.row]
      player = AVPlayer(url: URL(string: track.getTrackPreviewUrl())!)
      destination.presenter = MusicPlayerPresenter(player: player!, track: track)
    default:
      return
    }
  }
}

// MARK: - UISearchBarDelegate
extension SearchTableViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    let minLen = 2
    
    guard searchText.count > minLen else {
      cancelTargetNoTracks()
      tracks = []
      self.tableView.reloadData()
      return
    }
    
    searchTracks(str: searchText.lowercased())
    cancelTargetNoTracks()
    self.perform(#selector(noTracks), with: nil, afterDelay: 2)
  }
  
  private func cancelTargetNoTracks() {
    NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(noTracks), object: nil)
  }
  
  @objc func noTracks() {
    guard tracks.isEmpty else {
      return
    }
    
    present(AlertCreator.notification(message: "No tracks found"), animated: true, completion: nil)
  }
  
  private func searchTracks(str: String) {
    self.activityIndicator.startAnimating()
    ITunesApiManager(ITunesApi()).findTracks(searchText: str) {
      self.activityIndicator.stopAnimating()
      self.tracks = $0
      self.tableView.reloadData()
    }
  }
}
