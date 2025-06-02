//
//  HydrationTrackingApp.swift
//  HydrationTracking
//
//  Created by mona alruthaya on 04/12/1446 AH.
//
import SwiftUI

@main
struct HydrationTrackingApp: App {
    @StateObject var settings = UserSettings()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                WeightInputView()
            }
            .environmentObject(settings)
        }
    }
}
