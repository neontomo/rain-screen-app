import StoreKit
import SwiftUI

struct SystemSection: View {
  @Environment(\.requestReview) var requestReview
  @ObservedObject var settings = SettingsManager.shared
  let currentYear = String(Calendar.current.component(.year, from: Date()))

  var body: some View {
    Section(header: Text("system")) {
      Menu("about") {
        Section(header: Text("about")) {
          Divider()

          Button(
            "rain screen website",
            action: {
              openURL("https://rain-screen.netlify.app")
            })

          Button(
            "leave rating",
            action: {
              requestReview()
            })

          Button(
            "leave review",
            action: {
              openURL("macappstore://apps.apple.com/app/id6505049609?action=write-review")
            })

          Button(
            "privacy policy",
            action: {
              openURL("https://github.com/neontomo/rain-screen-app/blob/main/PRIVACY.md")
            })

          Divider()

          Button(
            "email me",
            action: {
              openURL("mailto:tomomyrman@proton.me?subject=rain%20screen%20feedback")
            })

          Button(
            "my other projects",
            action: {
              openURL("https://neontomo.com")
            })

          Divider()

          Button("\(currentYear) © Tomo Myrman", action: {}).disabled(true)
        }

      }

      Button("reset all settings") {
        settings.resetAllSettings()
      }

      Button("check for updates") {
        openURL("macappstore://apps.apple.com/app/id6505049609?action=update")
      }.keyboardShortcut("u", modifiers: [.command])

      Divider()

      Button("quit") {
        NSApp.terminate(self)
      }.keyboardShortcut("q", modifiers: [.command])
    }
  }
}

#Preview {
  SystemSection()
}
