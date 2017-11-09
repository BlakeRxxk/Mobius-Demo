//
//  ProfileViewTests.swift
//  Mobius-Demo-Visual-Regression-Testing
//
//  Created by Alexander Zimin on 09/11/2017.
//  Copyright © 2017 Mobius. All rights reserved.
//

import FBSnapshotTestCase
@testable import Mobius_Demo

class ProfileViewTests: FBSnapshotTestCase {

    struct FakeProfileViewModel: ProfileViewModelProtocol {
        var avatarViewModel: AvatarViewModelProtocol {
            return AvatarViewTests.FakeAvatarViewModel()
        }

        var name: String {
            return "Fake Name"
        }

        var age: Int {
            return 100
        }
    }

    override func setUp() {
        super.setUp()
//                recordMode = true
    }

    override func tearDown() {
        recordMode = false
        super.tearDown()
    }

    func testProfileView_AlignHorizontally() {
        let profileViewModel = FakeProfileViewModel()
        let profileView = ProfileView(viewModel: profileViewModel)

        self.place(view: profileView, widthSide: .selfSized, heightSide: .selfSized)
        profileView.evaluateAndCall(event: .alignHorizontally(duration: 0))
        FBSnapshotVerifyView(profileView)

        profileView.removeFromSuperview()
    }

    func testProfileView_AlignVertically() {
        let profileViewModel = FakeProfileViewModel()
        let profileView = ProfileView(viewModel: profileViewModel)

        self.place(view: profileView, widthSide: .selfSized, heightSide: .selfSized)
        profileView.evaluateAndCall(event: .alignVertically(duration: 0))
        FBSnapshotVerifyView(profileView)

        profileView.removeFromSuperview()
    }

}
