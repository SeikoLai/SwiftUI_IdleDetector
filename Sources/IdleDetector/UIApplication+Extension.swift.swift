import UIKit

// MARK: - UserActivityDelegate

/// Delegate to handle user activity detection.
class UserActivityDelegate: NSObject, UIGestureRecognizerDelegate {
    /// Sends a notification when a touch is detected.
    /// - Parameters:
    ///   - gestureRecognizer: The gesture recognizer that recognized the touch.
    ///   - touch: The touch that was recognized.
    /// - Returns: Always returns true to allow the touch to be received.
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldReceive touch: UITouch) -> Bool {
        NotificationCenter.default.post(name: .userDidInteract, object: nil)
        return true
    }
    
    /// Allows simultaneous recognition of gestures.
    /// - Parameters:
    ///   - gestureRecognizer: The gesture recognizer asking permission.
    ///   - otherGestureRecognizer: Another gesture recognizer that may be operating simultaneously.
    /// - Returns: Always returns true to allow simultaneous recognition.
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}

// MARK: - Tap Activity Gesture Recognizer

public extension UIApplication {
    /// The name of the user activity gesture recognizer.
    static let userActivityGestureRecognizer = "userActivityGestureRecognizer"
    
    // Store the UserActivityDelegate instance
    private static var userActivityDelegate: UserActivityDelegate?
    
    /// Checks if the user activity tracker is currently active.
    var hasUserActivityTracker: Bool {
        UIApplication.shared.windowsFirst?.gestureRecognizers?.contains(where: { $0.name == UIApplication.userActivityGestureRecognizer }) == true
    }
    
    /// Adds a tap gesture recognizer to intercept touches and track user activity.
    func addUserActivityTracker() {
        guard let window = UIApplication.shared.windowsFirst else { return }
        
        // Create and store the UserActivityDelegate instance
        UIApplication.userActivityDelegate = UserActivityDelegate()
        
        let gesture = UITapGestureRecognizer(target: window, action: nil)
        gesture.requiresExclusiveTouchType = false
        gesture.cancelsTouchesInView = false
        gesture.delegate = UIApplication.userActivityDelegate
        gesture.name = UIApplication.userActivityGestureRecognizer
        window.addGestureRecognizer(gesture)
    }
    
    /// Removes the tap gesture recognizer that detects user interactions.
    func removeUserActivityTracker() {
        guard let window = UIApplication.shared.windowsFirst,
              let gesture = window.gestureRecognizers?.first(where: { $0.name == UIApplication.userActivityGestureRecognizer })
        else {
            return
        }
        window.removeGestureRecognizer(gesture)
        
        // Remove the stored UserActivityDelegate instance
        UIApplication.userActivityDelegate = nil
    }
    
    /// Returns the first window of the first window scene.
    var windowsFirst: UIWindow? {
        self.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .windows
            .first
    }
    
    /// Returns the key window of the first window scene.
    var keyWindow: UIWindow? {
        self.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .windows
            .first { $0.isKeyWindow }
    }
}

// MARK: - Notification Name Extension

public extension Notification.Name {
    /// Notification name for user interaction events.
    static let userDidInteract = Notification.Name("userDidInteract")
}
