import SwiftUI

/*
TODO:
- auto-start rain at certain times (schedule)
*/

class WatermarkOverlayWindow: NSWindow {
  override init(
    contentRect: NSRect, styleMask style: NSWindow.StyleMask,
    backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool
  ) {
    super.init(
      contentRect: contentRect,
      styleMask: .borderless,
      backing: backingStoreType,
      defer: flag
    )
    self.level = .floating
    self.ignoresMouseEvents = true
    self.isReleasedWhenClosed = false
    self.isMovableByWindowBackground = false
    self.alphaValue = 1.0
    self.backgroundColor = NSColor.clear
    self.isOpaque = false
    self.hasShadow = false
  }
}

class AppDelegate: NSObject, NSApplicationDelegate {
  var windows = [NSWindow]()

  static private(set) var instance: AppDelegate!

  let useMultipleScreens = GlobalStateManager.shared.useMultipleScreens

  public func createWindow(for screen: NSScreen) {
    let screenRect = screen.frame
    createAndShowWindow(frame: screenRect)
  }

  public func createAndShowWindow(frame: NSRect) {
    let contentView = RainFallingView()
    let window = WatermarkOverlayWindow(
      contentRect: frame,
      styleMask: [.borderless],
      backing: .buffered, defer: false)

    window.contentView = NSHostingView(rootView: contentView)
    window.makeKeyAndOrderFront(nil)
    window.isReleasedWhenClosed = false
    windows.append(window)
  }

  public func closeAllWindows() {
    print("closeAllWindows")
    AppDelegate.instance.windows.forEach { window in
      window.close()
    }

    AppDelegate.instance.windows.removeAll()
  }

  public func applicationDidFinishLaunching(_ notification: Notification) {
    AppDelegate.instance = self

    if useMultipleScreens {
      NSScreen.screens.forEach { screen in
        createWindow(for: screen)
      }
    } else {
      if let screen = NSScreen.main {
        createWindow(for: screen)
      }
    }
  }
}
