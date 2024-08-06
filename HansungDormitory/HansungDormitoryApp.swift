//
//  HansungDormitoryApp.swift
//  HansungDormitory
//
//  Created by JangSoohee on 7/3/24.
//

import SwiftUI

@main
struct HansungDormitoryApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(appState)
        }
    }
}
