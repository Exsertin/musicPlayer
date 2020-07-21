//
//  SearchTableViewController.swift
//  musicPlayer
//
//  Created by Александр Левин on 19.07.2020.
//  Copyright © 2020 Exsertin. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
  @IBOutlet var searchBar: UISearchBar!
  
  let segueMusicPlayerId: String = "showMusicPlayer"
  
  var tracks: [TrackProtocol] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
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
      
      destination.presenter = MusicPlayerPresenter(track: tracks[indexPath.row])
    default:
      return
    }
  }
}

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
    self.perform(#selector(noTracks), with: nil, afterDelay: 3)
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
    ITunesApiManager(ITunesApi()).findSongs(searchText: str) {
      self.tracks = $0
      self.tableView.reloadData()
    }
  }
}
