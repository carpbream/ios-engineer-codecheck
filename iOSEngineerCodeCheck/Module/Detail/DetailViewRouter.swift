//
//  DetailViewRouter.swift
//  iOSEngineerCodeCheck
//
//  Created by 大内麻衣子 on 2022/11/06.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

class DetailRouter: RouterProtocol {
    typealias ControllerType = DetailViewController
    var controller: DetailViewController

    init(controller: DetailViewController) {
        self.controller = controller
    }
}
