//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

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

        /// 画像をダウンロードしてセットする処理。
        /// owner, ownerIconImageURLをguardletで取得していないのは、
        /// 今後、repoの内容を処理するが、ownerは利用しないような場合に、ここで処理が中断されないため。
        if let owner = item.owner {
            Task {
                guard let image = await getImage(urlString: owner.avatar_url) else {
                    print("ERROR: 画像の取得に失敗しました")
                    return
                }
                DispatchQueue.main.async {
                    self.ownerIconImageView.image = image
                }
            }
        }
    }

    func getImage(urlString: String) async -> UIImage? {

        do {
            let apiClient = APIClient()
            let data = try await apiClient.request(with: urlString)
            guard let image = UIImage(data: data) else {
                print("ERROR: invalid data. data: \(data.description)")
                return nil
            }
            return image
        } catch {
            print("ERROR: \(error.localizedDescription)")
            return nil
        }
    }

}
