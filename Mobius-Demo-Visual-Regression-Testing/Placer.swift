//
//  Placer.swift
//  Mobius-Demo-Visual-Regression-Testing
//
//  Created by Alexander Zimin on 09/11/2017.
//  Copyright © 2017 Mobius. All rights reserved.
//

import UIKit
import FBSnapshotTestCase

extension FBSnapshotTestCase {
    enum Side {
        case selfSized
        case byRoot
        case value(value: CGFloat)
    }

    func place(view: UIView, widthSide: Side, heightSide: Side) {
        guard let window = UIApplication.shared.keyWindow else {
            assertionFailure("No Application key windonw")
            return
        }

        guard let rootViewController = window.rootViewController else {
            assertionFailure("No Root View Controller")
            return
        }

        rootViewController.view.addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false

        view.topAnchor.constraint(equalTo: rootViewController.view.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: rootViewController.view.leadingAnchor).isActive = true

        switch widthSide {
        case .selfSized:
            break
        case .byRoot:
            view.trailingAnchor.constraint(equalTo: rootViewController.view.trailingAnchor).isActive = true
        case let .value(value):
            view.widthAnchor.constraint(equalToConstant: value).isActive = true
        }

        switch heightSide {
        case .selfSized:
            break
        case .byRoot:
            view.bottomAnchor.constraint(equalTo: rootViewController.view.bottomAnchor).isActive = true
        case let .value(value):
            view.heightAnchor.constraint(equalToConstant: value).isActive = true
        }
    }
}
