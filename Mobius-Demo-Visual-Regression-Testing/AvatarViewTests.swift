//
//  AvatarViewTests.swift
//  Mobius-Demo-Visual-Regression-Testing
//
//  Created by Alexander Zimin on 09/11/2017.
//  Copyright © 2017 Mobius. All rights reserved.
//

import FBSnapshotTestCase
@testable import Mobius_Demo

class AvatarViewTests: FBSnapshotTestCase {

    struct FakeAvatarViewModel: AvatarViewModelProtocol {
        var image: UIImage {
            return UIImage(named: "image")!
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

    func testAvatarView_Appear() {
        let avatartViewModel = FakeAvatarViewModel()
        let avatatView = AvatarView(viewModel: avatartViewModel)

        self.place(view: avatatView, widthSide: .value(value: 100), heightSide: .value(value: 100))
        avatatView.evaluateAndCall(event: .avatarAppear(duration: 0))
        FBSnapshotVerifyView(avatatView)

        avatatView.removeFromSuperview()
    }

    func testAvatarView_Dissapear() {
        let avatartViewModel = FakeAvatarViewModel()
        let avatatView = AvatarView(viewModel: avatartViewModel)

        self.place(view: avatatView, widthSide: .value(value: 100), heightSide: .value(value: 100))
        avatatView.evaluateAndCall(event: .avatarDissapear(duration: 0))
        FBSnapshotVerifyView(avatatView)

        avatatView.removeFromSuperview()
    }

}
