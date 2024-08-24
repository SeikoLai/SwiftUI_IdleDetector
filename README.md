# IdleDetector

IdleDetector is a Swift library for iOS that helps you track user activity and detect idle time in your SwiftUI applications. It provides a simple way to add idle time detection to your views and react to changes in user activity.

## Features

- Easy integration with SwiftUI views
- Customizable idle time threshold
- Automatic tracking of user interactions
- Access to idle time and idle state through environment objects
- Thread-safe implementation using Swift's concurrency model

## Requirements

- iOS 14.0+
- Swift 5.5+
- Xcode 13.0+

## Installation

### Swift Package Manager

You can install IdleDetector using the [Swift Package Manager](https://swift.org/package-manager/):

1. In Xcode, select "File" → "Swift Packages" → "Add Package Dependency"
2. Enter the repository URL: `https://github.com/SeikoLai/SwiftUI_IdleDetector.git`
3. Select the version you want to use

Alternatively, you can add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/SeikoLai/SwiftUI_IdleDetector.git", from: "1.0.0")
]
```

## Usage

### Basic Usage

1. Import the IdleDetector module in your SwiftUI view file:

```swift
import SwiftUI
import IdleDetector
```

2. Apply the idle detection to your view:

```swift
struct ContentView: View {
    var body: some View {
        IdleDetector.trackUserActivity(
            Text("Hello, World!")
        )
    }
}
```

### Accessing Idle Time Information

You can access the idle time information in child views using the `@EnvironmentObject` property wrapper:

```swift
struct IdleTimeView: View {
    @EnvironmentObject var idleTimeManager: IdleTimeManager

    var body: some View {
        VStack {
            Text("Idle Time: \(Int(idleTimeManager.idleTime)) seconds")
            Text("Is Idle: \(idleTimeManager.isIdle ? "Yes" : "No")")
        }
    }
}
```

### Customizing Idle Threshold

You can customize the idle time threshold when applying the tracker:

```swift
IdleDetector.trackUserActivity(
    YourView(),
    idleThreshold: 30 // Set idle threshold to 30 seconds
)
```

## API Reference

### IdleDetector

The main interface for the IdleDetector library.

- `static func trackUserActivity<Content: View>(_ content: Content, idleThreshold: TimeInterval = 10) -> some View`
  
  Applies the user activity tracker to a view.

### IdleTimeManager

Manages and tracks idle time in an application.

- `var idleTime: TimeInterval` (read-only)
  
  The current idle time in seconds.

- `var isIdle: Bool` (read-only)
  
  Indicates whether the application is considered idle.

- `func resetIdleTime()`
  
  Resets the idle time when user interaction is detected.

## Thread Safety

IdleDetector uses Swift's concurrency model to ensure thread safety. The main components are marked with `@MainActor` to ensure they're always accessed on the main thread, preventing potential race conditions and ensuring smooth integration with SwiftUI's view lifecycle.

## License

IdleDetector is released under the MIT License. See [LICENSE](LICENSE) for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Support

If you have any questions or issues, please open an issue on the GitHub repository.

## Changelog

### 1.0.1

- Improved thread safety using Swift's actor model
- Fixed issues related to accessing UI components from background threads

### 1.0.0

- Initial release
