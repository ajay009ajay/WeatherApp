//
//  HostingController.swift
//  Coordinator
//
//  Created by Ajay Kumar Singh on 07/04/25.
//

import UIKit
import SwiftUI

class HostingController<HostingView: View>: UIHostingController<HostingView> {

    override init(rootView: HostingView) {
        super.init(rootView: rootView)
    }

    @available(*, unavailable)
    @MainActor dynamic required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

