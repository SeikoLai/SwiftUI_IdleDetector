//
//  File.swift
//  SwiftUI_IdleTimeManager
//
//  Created by Sam on 2024/8/24.
//

import SwiftUI

/// A custom ViewModifier to add and remove user activity tracking.
@MainActor
public struct UserActivityTrackerModifier: ViewModifier {
    @StateObject private var idleTimeManager: IdleTimeManager
    
    /// Initializes a new UserActivityTrackerModifier.
    /// - Parameter idleThreshold: The time in seconds after which the app is considered idle. Defaults to 10 seconds.
    public init(idleThreshold: TimeInterval = 10) {
        _idleTimeManager = StateObject(wrappedValue: IdleTimeManager(idleThreshold: idleThreshold))
    }
    
    public func body(content: Content) -> some View {
        content
            .onAppear {
                UIApplication.shared.addUserActivityTracker()
            }
            .onDisappear {
                if UIApplication.shared.hasUserActivityTracker {
                    UIApplication.shared.removeUserActivityTracker()
                }
            }
            .environmentObject(idleTimeManager)
    }
}

public extension View {
    /// Applies the user activity tracker to a view.
    /// - Parameter idleThreshold: The time in seconds after which the app is considered idle. Defaults to 10 seconds.
    /// - Returns: A view with user activity tracking applied.
    func userActivityTracker(idleThreshold: TimeInterval = 10) -> some View {
        modifier(UserActivityTrackerModifier(idleThreshold: idleThreshold))
    }
}
