//
//  ProfileViewController.swift
//  RickAndMortyApplication
//
//  Created by Mitina Ekaterina on 22.08.2025.
//

import UIKit

final class ProfileViewController: UIViewController {

    lazy var contentView: DisplaysProfile = ProfileView()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        displaysEpisodes()
    }

}

extension ProfileViewController {
    func displaysEpisodes() {
        contentView.setupEpisodes(array)
    }
}

let array = [mock1, mock2, mock3, mock4, mock5, mock6, mock7, mock8, mock9, mock10, mock11]
fileprivate let mock1 = EpisodeModel(name: "name1", episodeNumber: "num1", date: "date1")
fileprivate let mock2 = EpisodeModel(name: "name2", episodeNumber: "num2", date: "date2")
fileprivate let mock3 = EpisodeModel(name: "name3", episodeNumber: "num3", date: "date2")
fileprivate let mock4 = EpisodeModel(name: "name4", episodeNumber: "num4", date: "date2")
fileprivate let mock5 = EpisodeModel(name: "name5", episodeNumber: "num5", date: "date2")
fileprivate let mock6 = EpisodeModel(name: "name6", episodeNumber: "num2", date: "date2")
fileprivate let mock7 = EpisodeModel(name: "name7", episodeNumber: "num2", date: "date2")
fileprivate let mock8 = EpisodeModel(name: "name8", episodeNumber: "num2", date: "date2")
fileprivate let mock9 = EpisodeModel(name: "name9", episodeNumber: "num2", date: "date2")
fileprivate let mock10 = EpisodeModel(name: "name10", episodeNumber: "num10", date: "date2")
fileprivate let mock11 = EpisodeModel(name: "name11", episodeNumber: "num11", date: "date2")
