# AraxUI

Design system package for iOS 16+ (SwiftUI + UIKit).

## Install

Add the package in Xcode via **File → Add Package Dependencies → Add Local…**,
or declare it as a dependency:

```swift
dependencies: [
    .package(url: "https://github.com/<owner>/AraxUI.git", from: "0.1.0")
],
targets: [
    .target(name: "MyApp", dependencies: ["AraxUI"])
]
```

## Components

Everything below is `public`. `import AraxUI` and use it.

### AraxButton

A capsule button with a press animation. Colors are explicit, so pass tokens:

```swift
AraxButton(
    backgroundColor: AraxTheme.current.mainColorPrimary.color,
    foregroundColor: AraxTheme.current.additionalColorsWhite.color,
    borderColor: nil,        // optional, default nil
    borderWidth: 1,          // only used when borderColor is set
    action: { save() }
) {
    Text("Save")
}
```

`AraxButtonStyle` is public too, if you want the same press behaviour on a
plain `Button`:

```swift
Button("Cancel") { dismiss() }
    .buttonStyle(AraxButtonStyle())
```

### AraxToolbar

A 55pt title bar with a leading back chevron. Both colors default to tokens,
so the common case is one argument:

```swift
AraxToolbar(title: "Profile") { router.pop() }

AraxToolbar(
    title: "Profile",
    foregroundColor: .white,
    backgroundColor: AraxTheme.current.mainColorDarkGray.color,
    action: { router.pop() }
)
```

### AraxToast

`AraxToast` is the capsule itself; `.araxToast(isPresented:)` presents one over
any view and flips the binding back to `false` after `duration`:

```swift
@State private var didSave = false

ContentView()
    .araxToast(isPresented: $didSave, duration: .seconds(2)) {
        AraxToast("Saved")                                  // Label + checkmark
    }
```

The convenience initializer takes a message and an SF Symbol name. For
anything else, build the content yourself:

```swift
.araxToast(isPresented: $didFail, onDismiss: { retry() }) {
    AraxToast {
        HStack {
            Image(systemName: "exclamationmark.triangle.fill")
            Text("Upload failed")
        }
        .foregroundStyle(AraxTheme.current.alertsError.color)
    }
}
```

### AraxTextField

A capsule text field with optional leading and trailing icons. The trailing
icon is an `AraxImageHandler` — a tuple of the image and an optional tap
handler:

```swift
@State private var query = ""

AraxTextField(
    leadingIcon: UIImage(systemName: "magnifyingglass"),
    currentTypedText: $query,
    trailingIcon: (image: UIImage(systemName: "xmark.circle.fill")!,
                   didTap: { query = "" }),
    placeholder: "Search",
    shouldInterceptFocus: false,
    onFocusedAction: { isFocused in print(isFocused) }
)
```

Set `shouldInterceptFocus: true` when a tap should not open the keyboard but
run `onFocusedAction` instead — for a field that opens a picker, say.

From UIKit, drive it through `AraxTextFieldViewModel` and the hosting
controller, which self-sizes:

```swift
final class SearchViewController: UIViewController, AraxTextFieldViewModelDelegate {
    private let viewModel = AraxTextFieldViewModel(
        leadingIcon: UIImage(systemName: "magnifyingglass"),
        placeholderText: "Search"
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self

        let field = AraxTextFieldHostingController(viewModel: viewModel)
        addChild(field)
        view.addSubview(field.view)
        field.didMove(toParent: self)
        // ...constrain field.view
    }

    func notifyAraxTextFieldDidChangeFocus(_ viewModel: AraxTextFieldViewModel, isFocused: Bool) {
        // react to focus
    }
}
```

Read or write the text through `viewModel.currentTypedText` (it is
`@Published`). Both `AraxTextFieldViewModel` and
`AraxTextFieldViewModelDelegate` are `@MainActor`, which is why a
`UIViewController` can conform to the delegate with no extra annotation.

### AraxBottomSheet

A UIKit sheet sized to its content, with a dimmed backdrop, a close button, and
an image/title/message stack. Present it with
`AraxBottomSheetTransitionDelegate`:

```swift
final class HomeViewController: UIViewController {
    // Must be stored: UIKit holds `transitioningDelegate` weakly.
    private let sheetTransition = AraxBottomSheetTransitionDelegate()

    func showSheet() {
        let sheet = AraxBottomSheet(
            image: UIImage(named: "success"),
            title: "Payment sent",
            message: "We emailed you a receipt."
        )
        sheet.modalPresentationStyle = .custom
        sheet.transitioningDelegate = sheetTransition
        present(sheet, animated: true)
    }
}
```

`AraxBottomSheet` is `open`, and `verticalStackView` is public, so a subclass
can append its own content:

```swift
final class ConfirmSheet: AraxBottomSheet {
    override func viewDidLoad() {
        super.viewDidLoad()
        verticalStackView.addArrangedSubview(confirmButton)
    }
}
```

### AraxViewModel / AraxLoadState

An optional pair for app view models that load something. `AraxLoadState` is
the state enum, `AraxViewModel` is the `@MainActor` protocol that adds
`isLoading` and `resetState()`:

```swift
@MainActor
final class ProfileViewModel: AraxViewModel {
    @Published var state: AraxLoadState<Profile> = .idle

    func load() async {
        state = .loading
        do { state = .success(try await api.profile()) }
        catch { state = .failure(error.localizedDescription) }
    }
}
```

`AraxLoadState` exposes `isLoading`, `isSuccess`, `value` and `errorMessage`,
and is `Equatable` when `Value` is.

## Design tokens

All colors live on `AraxTheme`. Each token is an `AraxColor`, which holds a
light and a dark appearance and resolves between them automatically from the
current trait collection:

```swift
import AraxUI

Text("Hello")
    .foregroundStyle(AraxTheme.current.mainColorPrimary.color)   // SwiftUI

label.textColor = AraxTheme.current.mainColorPrimary.uiColor      // UIKit
```

## Customizing the tokens

`AraxTheme.current` is a plain mutable struct, so an app overrides only the
tokens it cares about and inherits the rest. Do it once, at launch, before any
view or view controller is created:

```swift
import AraxUI
import SwiftUI

@main
struct MyApp: App {
    init() {
        AraxTheme.current.mainColorPrimary = AraxColor("#FF5A1F")
        AraxTheme.current.mainColorSecondary = AraxColor(light: "#FFFFFF", dark: "#101010")
        AraxTheme.current.alertsError = AraxColor(light: .systemRed, dark: .systemPink)
    }

    var body: some Scene {
        WindowGroup { ContentView() }
    }
}
```

Or replace the whole palette at once:

```swift
var theme = AraxTheme()
theme.mainColorPrimary = AraxColor("#FF5A1F")
theme.grayscale100 = AraxColor(light: "#000000", dark: "#FFFFFF")
AraxTheme.current = theme
```

`AraxColor` has four initializers: `AraxColor("#RRGGBB")` for one hex in both
appearances, `AraxColor(light:dark:)` with hex strings or with `UIColor`s, and
`AraxColor(_ color: UIColor)` for a single `UIColor`. Hex accepts `RRGGBB` and
`RRGGBBAA`, with or without the leading `#`.

### Why it is a write-once global

`AraxTheme.current` is `nonisolated(unsafe)` storage: it is read from
nonisolated contexts (UIKit initializers, `TextFieldStyle._body`) and is
expected to be written exactly once, at launch. Mutating it after views exist
is a data race, and existing SwiftUI views will not re-render. If per-screen
theming or live theme switching is ever needed, move the theme into an
`EnvironmentValues` key.

## Everything else that is public

The whole package is `public`. Beyond the components and tokens above:

| Symbol | Use |
| --- | --- |
| `UIColor.from(_:)`, `UIColor.toColor()` | hex string to `UIColor`, `UIColor` to `Color` |
| `Color(hex:)` | hex string to `Color` (3, 6 or 8 digits) |
| `Color.primaryGreenColor`, `.primaryBlackColor`, `.primaryWhiteColor` | three fixed colors predating `AraxTheme` |
| `LinearGradient.vertical(_:)`, `.horizontal(_:)`, `.gradient(axis:stops:)`, `.makeStops(from:)`, `GradientAxis` | weighted multi-stop gradients |
| `View.baseRoundedCorner()`, `View.capsuleRounded()`, `araxBaseCornerRadius` | the package's two corner shapes |
| `View.stretch()`, `EnvironmentValues.isStretch`, `StretchKey` | stretch flag for `AraxButton` |
| `OnFirstAppearModifier` | run an action on the first `onAppear` only |
| `ViewControllerPreview`, `ViewPreview` | wrap UIKit in a SwiftUI preview (`#if DEBUG` only) |
| `UIApplication.topViewController(base:)` | walk to the visible view controller |
| `ObservableObject.binding(_:)` | `Binding` from a reference-writable key path |
| `AraxTextFieldStyle`, `araxInputHeight` | the text field's `TextFieldStyle` and its 52pt height |
| `AraxBottomSheetPresentationController` (`open`), `AraxBottomSheetAnimator` | the sheet's sizing/dimming and its spring transition |
| `AraxBottomSheet.dismissButton`, `.imageView`, `.titleLabel`, `.messageLabel`, `.verticalStackView` | subviews, for restyling in a subclass |
| `AraxBottomSheet.setupView()`, `.dismissTapped()` | build the subview hierarchy, dismiss the sheet |

`setupView()` lives in an extension, so it is callable but **not**
overridable — Swift does not dispatch extension methods dynamically. Move it
into the class body and mark it `open` if a subclass needs to replace it.

Two file-scope constants were renamed when they became public, because a
public global needs a prefix to survive in someone else's namespace:
`kInputHeight` is now `araxInputHeight` and `baseCornerRadius` is now
`araxBaseCornerRadius`.

`Color`, `UIColor`, `View`, `EnvironmentValues`, `LinearGradient`,
`UIApplication` and `ObservableObject` all carry public extensions from this
package, so those members appear on those types in every file that imports
`AraxUI`. `Color.primaryGreenColor` and friends also duplicate what
`AraxTheme` now covers — prefer the theme for new code.
