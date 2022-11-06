//
//  RouterProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by 大内麻衣子 on 2022/11/06.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

protocol RouterProtocol {
    associatedtype ControllerType: ControllerProtocol
    var controller: ControllerType { get }

    func move(to destination: Destination, params: Any?)
    func back()
}

extension RouterProtocol {
    func move(to destination: Destination, params: Any?) {

        DispatchQueue.main.async {
            let viewIdentifier = destination.rawValue
            let storyBoard = UIStoryboard(name: viewIdentifier, bundle: nil)
            guard let nextController = storyBoard.instantiateInitialViewController() else {
                print("ViewControllerが存在しません。ViewController名: \(viewIdentifier)")
                return
            }

            if nextController is DetailViewController {
                (nextController as! DetailViewController).params = params
            }

            guard let nav = self.controller.navigationController else {
                // 今回はNavigationControllerを利用する前提のため、
                // NavigationControllerが取得できない場合は遷移を行わない
                print("NavigationControllerが見つかりませんでした。")
                return
            }

            nav.pushViewController(nextController, animated: true)
        }
    }

    func back() {
        DispatchQueue.main.async {
            self.controller.dismiss(animated: true)
        }
    }
}

// タイポを防ぐためViewController名をenumで定義
enum Destination: String {
    case ListViewController
    case DetailViewController
}
