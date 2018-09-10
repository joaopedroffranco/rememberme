//
//  Coordinator.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 07/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import UIKit

protocol Coordinador {
    var next: Coordinador! { get set }
    func present()
}
