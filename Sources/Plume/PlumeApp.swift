// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import AppKit

@main
struct PlumeApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
