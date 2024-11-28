//
//  MonitorSection.swift
//  rain screen
//
//  Created by Tomo Myrman on 2024-07-06.
//

import SwiftUI

struct MonitorSection: View {
  @ObservedObject var settings = SettingsManager.shared

  var body: some View {
    Section(header: Text("monitors")) {

      Button(action: {
        createConfirmPopup(
          title: "restart needed",
          message:
            "quit and <manually> restart the app to apply the change.",
          action: {
            settings.useMultipleScreens.toggle()
            NSApp.terminate(nil)
          }
        )
      }) {
        Toggle(
          isOn: .constant(
            settings.useMultipleScreens
          )
        ) {
          Text("show on all monitors")
        }
      }
    }
  }
}

#Preview {
  MonitorSection()
}
