//
//  ListViewRouter.swift
//  iOSEngineerCodeCheck
//
//  Created by 大内麻衣子 on 2022/11/06.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

class ListViewRouter: RouterProtocol {
    typealias ControllerType = ListViewController

    var controller: ListViewController

    init(controller: ListViewController) {
        self.controller = controller
    }
}
