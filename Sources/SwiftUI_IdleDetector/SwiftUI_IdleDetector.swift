// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI

/// The main interface for the IdleDetector library.
public struct IdleDetector {
    /// The current version of the IdleDetector library.
    public static let version = "1.0.0"
    
    /// Applies the user activity tracker to a view.
    /// - Parameters:
    ///   - content: The content view to which the tracker will be applied.
    ///   - idleThreshold: The time in seconds after which the app is considered idle. Defaults to 10 seconds.
    /// - Returns: A view with user activity tracking applied.
    public static func trackUserActivity<Content: View>(_ content: Content, idleThreshold: TimeInterval = 10) -> some View {
        content.userActivityTracker(idleThreshold: idleThreshold)
    }
}
