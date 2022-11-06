//
//  PresenterProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by 大内麻衣子 on 2022/11/06.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol PresenterProtocol {
    associatedtype ControllerType: ControllerProtocol
    associatedtype RouterType: RouterProtocol

    var controller: ControllerType? { get }
    var router: RouterType { get }
}
