//
//  ControllerProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by 大内麻衣子 on 2022/11/06.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

protocol ControllerProtocol: UIViewController {
    associatedtype PresenterType: PresenterProtocol

    var presenter: PresenterType? { get set }
    var params: Any? { get set }
}
