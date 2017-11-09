//
//  StatableView.swift
//  Mobius-Demo
//
//  Created by Alexander Zimin on 09/11/2017.
//  Copyright © 2017 Mobius. All rights reserved.
//

import Foundation

protocol StatableView {
    associatedtype Event
    associatedtype Update
    associatedtype Action

    func evaluate(event: Event) -> Result<Update, Action>
    func apply(update: Update)
    func perfom(action: Action)
}

extension StatableView {
    func evaluateAndCall(event: Event) {
        let result = evaluate(event: event)
        result.updates.forEach(apply)
        result.actions.forEach(perfom)
    }
}

struct Result<Update, Action> {
    let updates: [Update]
    let actions: [Action]
}
