import SwiftUI

@main
struct MenuItemsApp: App {
  @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  @ObservedObject var globalStateManager = GlobalStateManager.shared

  let versionNumber =
    Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0"

  var body: some Scene {

    MenuBarExtra {
      Section(header: Text("🌧️ rain screen v\(versionNumber)")) {}
      CustomisationsSection()
      SoundsSection()
      MonitorSection()
      SystemSection()

    } label: {
      Image("CWC")
        .resizable()
        .frame(width: 16, height: 16)
    }
  }
}
