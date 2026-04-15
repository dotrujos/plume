// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

@main
struct Plume: App {
    init() {
        #if os(macOS)
        NSApplication.shared.setActivationPolicy(.regular)
        NSApplication.shared.activate(ignoringOtherApps: true)
        #endif
    }
    
    var body: some Scene {
        WindowGroup {
            Text("Hii")
        }
    }
}
