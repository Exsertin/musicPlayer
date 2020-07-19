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
  
  var songs: [ITunesResult.Result] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return songs.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
    let song = songs[indexPath.row]
    cell.textLabel?.text = "\(song.artistName) - \(song.trackName)"
    
    return cell
  }
}

extension SearchTableViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    let minLen = 2
    
    guard searchText.count > minLen else {
      songs = []
      self.tableView.reloadData()
      return
    }
    
    searchSongs(str: searchText.lowercased())
    NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(noSongs), object: nil)
    self.perform(#selector(noSongs), with: nil, afterDelay: 3)
  }
  
  @objc func noSongs() {
    guard songs.isEmpty else {
      return
    }
    
    present(AlertCreator.notification(message: "No songs found"), animated: true, completion: nil)
  }
  
  private func searchSongs(str: String) {
    ITunesApiManager(ITunesApi()).findSongs(searchText: str) {
      self.songs = $0
      self.tableView.reloadData()
    }
  }
}
