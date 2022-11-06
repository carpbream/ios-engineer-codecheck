//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController, ControllerProtocol {
    typealias PresenterType = DetailViewPresenter

    @IBOutlet weak var ownerIconImageView: UIImageView!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var langageLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var watcherCountLabel: UILabel!
    @IBOutlet weak var forkCountLabel: UILabel!
    @IBOutlet weak var issueCountLabel: UILabel!

    var presenter: DetailViewPresenter?
    var params: Any?

    override func viewDidLoad() {
        super.viewDidLoad()
        let presenter = DetailViewPresenter(controller: self)
        self.presenter = presenter
        guard let item = params as? Item else {
            print("itemが選択されていません")
            presenter.router.back()
            return
        }

        langageLabel.text = presenter.createLanguageText(for: item)
        starCountLabel.text = presenter.createStarCountText(for: item)
        watcherCountLabel.text = presenter.createWtacherCountText(for: item)
        forkCountLabel.text = presenter.createForkCountText(for: item)
        issueCountLabel.text = presenter.createIssuesCountText(for: item)
        repositoryNameLabel.text = item.full_name

        if let owner = item.owner, let url = URL(string: owner.avatar_url) {
            DispatchQueue.main.async {
                self.ownerIconImageView.kf.setImage(with: url)
            }
        }
    }

}
