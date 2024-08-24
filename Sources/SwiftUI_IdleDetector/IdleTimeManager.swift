// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI
import Combine

/// Manages and tracks idle time in an application.
public class IdleTimeManager: ObservableObject {
    /// The current idle time in seconds.
    @Published public private(set) var idleTime: TimeInterval = 0
    
    /// Indicates whether the application is considered idle.
    @Published public private(set) var isIdle: Bool = false
    
    private var timer: AnyCancellable?
    private var interactionSubscription: AnyCancellable?
    private var idleThreshold: TimeInterval
    
    /// Initializes a new IdleTimeManager.
    /// - Parameter idleThreshold: The time in seconds after which the app is considered idle. Defaults to 10 seconds.
    public init(idleThreshold: TimeInterval = 10) {
        self.idleThreshold = idleThreshold
        
        startTimer()
        setupInteractionObserver()
    }
    
    /// Starts the timer to increment idle time every second.
    private func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.idleTime += 1
                self.isIdle = self.idleTime >= self.idleThreshold
            }
    }
    
    /// Sets up an observer for user interactions.
    private func setupInteractionObserver() {
        interactionSubscription = NotificationCenter.default
            .publisher(for: .userDidInteract)
            .sink { [weak self] _ in
                self?.resetIdleTime()
            }
    }
    
    /// Resets the idle time when user interaction is detected.
    public func resetIdleTime() {
        idleTime = 0
        isIdle = false
    }
}
