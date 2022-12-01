//
//  HarrisonAppApp.swift
//  HarrisonApp
//
//  Created by Harrison Carroll on 01/12/2022.
//

import SwiftUI

@main
struct HarrisonApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(ContentModel())
        }
    }
}
