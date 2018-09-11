//
//  Session.swift
//  RememberMe
//
//  Created by João Pedro Fabiano Franco on 11/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import Foundation

protocol SessionInterface {
    var lastAccess: Date { get }
    var shouldStartAgain: Bool { get }
    var duration: TimeInterval { get }
}

class Session {
    var duration: TimeInterval = 10
    var lastAccess: Date = Date()
    var shouldStartAgain: Bool {
        let now = Date()
        return now.timeIntervalSince(self.lastAccess) > self.duration
    }
}
