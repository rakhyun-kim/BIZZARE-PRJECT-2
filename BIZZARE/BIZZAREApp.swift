//
//  BIZZAREApp.swift
//  BIZZARE
//
//  Created by Rakhyun Kim on 2/7/25.
//

import SwiftUI

@main
struct BIZZAREApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}
