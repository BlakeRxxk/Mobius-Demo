//
//  ProfileView.swift
//  Mobius-Demo
//
//  Created by Alexander Zimin on 09/11/2017.
//  Copyright © 2017 Mobius. All rights reserved.
//

import UIKit

protocol ProfileViewModelProtocol {
    var avatarViewModel: AvatarViewModelProtocol { get }
    var name: String { get }
    var age: Int { get }
}

extension ProfileViewModelProtocol {
    var fullName: String {
        return name + ", " + "\(age)"
    }
}

class ProfileView: UIView {
    let viewModel: ProfileViewModelProtocol

    private var avatarView: AvatarView
    private var titleLabel: UILabel = UILabel()
    private var stackView = UIStackView()

    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        self.avatarView = AvatarView(viewModel: viewModel.avatarViewModel)
        super.init(frame: .zero)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpAvatartView()
        setUpTitleLabel()
        setUpStackView()
    }

    private func setUpAvatartView() {
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        avatarView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }

    private func setUpTitleLabel() {
        titleLabel.text = viewModel.fullName
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setUpStackView() {
        let stackView = self.stackView
        self.addSubview(stackView)
        stackView.addArrangedSubview(avatarView)
        stackView.addArrangedSubview(titleLabel)
        stackView.spacing = 16

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

        stackView.distribution = .equalCentering
        stackView.alignment = .center

        stackView.axis = .vertical
    }
}

// MARK: - States

extension ProfileView {
    enum Event {
        case alignHorizontally(duration: CGFloat)
        case alignVertically(duration: CGFloat)
    }

    enum Update {
        case changeAxis(duration: CGFloat, axis: UILayoutConstraintAxis)
        case avatarBlink(duration: CGFloat)
    }

    enum Action { }
}

extension ProfileView: StatableView {
    func evaluate(event: Event) -> Result<Update, Action> {
        switch event {
        case let .alignHorizontally(duration):
            return Result(updates: [.changeAxis(duration: duration, axis: .horizontal), .avatarBlink(duration: duration)], actions: [])
        case let .alignVertically(duration):
            return Result(updates: [.changeAxis(duration: duration, axis: .vertical), .avatarBlink(duration: duration)], actions: [])
        }
    }

    func apply(update: Update) {
        switch update {
        case let .changeAxis(duration, axis):
            let action = {
                self.stackView.axis = axis
            }
            if duration != 0 {
                UIView.animate(withDuration: TimeInterval(duration), animations: action)
            } else {
                action()
            }
        case let .avatarBlink(duration):
            avatarView.evaluateAndCall(event: .avatarBlink(duration: duration))
        }
    }

    func perfom(action: Action) { }
}
