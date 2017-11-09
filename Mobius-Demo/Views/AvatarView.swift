//
//  AvatarView.swift
//  Mobius-Demo
//
//  Created by Alexander Zimin on 09/11/2017.
//  Copyright © 2017 Mobius. All rights reserved.
//

import UIKit

protocol AvatarViewModelProtocol {
    var image: UIImage { get }
}

class AvatarView: UIView {
    let viewModel: AvatarViewModelProtocol
    private var imageView: UIImageView = UIImageView(frame: .zero)

    init(viewModel: AvatarViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        let imageView = self.imageView

        self.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

        imageView.image = self.viewModel.image
    }
}

// MARK: - States

extension AvatarView {
    enum Event {
        case avatarAppear(duration: CGFloat)
        case avatarDissapear(duration: CGFloat)
        case avatarBlink(duration: CGFloat)
    }

    enum Update {
        case alphaUpdate(duration: CGFloat, value: CGFloat)
        case blink(duration: CGFloat)
    }

    enum Action { }
}

extension AvatarView: StatableView {
    func evaluate(event: Event) -> Result<Update, Action> {
        switch event {
        case let .avatarAppear(duration):
            return Result(updates: [.alphaUpdate(duration: duration, value: 1)], actions: [])
        case let .avatarDissapear(duration):
            return Result(updates: [.alphaUpdate(duration: duration, value: 0)], actions: [])
        case let .avatarBlink(duration):
            return Result(updates: [.blink(duration: duration)], actions: [])
        }
    }

    func apply(update: Update) {
        switch update {
        case let .alphaUpdate(duration, value):
            let action = {
                self.imageView.alpha = value
            }
            if duration != 0 {
                UIView.animate(withDuration: TimeInterval(duration), animations: action)
            } else {
                action()
            }
        case let .blink(duration):
            let startAction = {
                self.imageView.alpha = 0
            }
            let endAction = {
                self.imageView.alpha = 1
            }
            if duration != 0 {
                // Yes, I know about keyframe and it's benefits, it's just an example
                UIView.animate(withDuration: TimeInterval(duration / 2), animations: startAction, completion: {
                    _ in
                    UIView.animate(withDuration: TimeInterval(duration / 2), animations: endAction)
                })
            } else {
                endAction()
            }
        }
    }

    func perfom(action: Action) { }
}
