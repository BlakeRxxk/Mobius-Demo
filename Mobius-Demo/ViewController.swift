//
//  ViewController.swift
//  Mobius-Demo
//
//  Created by Alexander Zimin on 09/11/2017.
//  Copyright © 2017 Mobius. All rights reserved.
//

import UIKit

struct AvatarViewModel: AvatarViewModelProtocol {
    var image: UIImage
}

struct ProfileViewModel: ProfileViewModelProtocol {
    var avatarViewModel: AvatarViewModelProtocol
    var name: String
    var age: Int
}

class ViewController: UIViewController {

    var profileView: ProfileView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let avatarViewModel = AvatarViewModel(image: UIImage(named: "image")!)
        let profileViewModel = ProfileViewModel(avatarViewModel: avatarViewModel, name: "Alexander", age: 22)
        let profileView = ProfileView(viewModel: profileViewModel)

        self.view.addSubview(profileView)

        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        profileView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true

        self.profileView = profileView
    }

    @IBAction func switchAction(_ sender: UISwitch) {
        if sender.isOn {
            profileView.evaluateAndCall(event: .alignVertically(duration: 0.5))
        } else {
            profileView.evaluateAndCall(event: .alignHorizontally(duration: 0.5))
        }
    }
}

