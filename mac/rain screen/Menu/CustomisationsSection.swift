import SwiftUI

struct CustomisationsSection: View {
  @ObservedObject var settings = SettingsManager.shared

  var body: some View {
    Section(header: Text("customisations")) {
      Button(action: {
        settings.rainAnimation.toggle()
      }) {
        Toggle(isOn: .constant(settings.rainAnimation)) {
          Text("rain animation")
        }.keyboardShortcut("a", modifiers: [.command])
      }

      Menu("rain speed") {
        Section(header: Text("rain speed")) {
          Divider()

          ForEach(1...10, id: \.self) { rainSpeedItem in
            Button(action: {
              settings.rainSpeed = Double(rainSpeedItem)
            }) {
              Toggle(
                isOn: .constant(eq(settings.rainSpeed, Double(rainSpeedItem)))
              ) {
                Text("\(rainSpeedItem)s")
              }
            }
          }

          Divider()

          Button(
            "reset",
            action: {
              settings.rainSpeed = 2
            })
        }
      }

      Menu("raindrops amount") {
        Section(header: Text("raindrops amount")) {
          Divider()

          ForEach([50, 100, 200, 300, 400, 500, 1000], id: \.self) { raindropsItem in
            Button(action: {
              settings.rainAmount = raindropsItem
            }) {
              Toggle(isOn: .constant(eq(settings.rainAmount, raindropsItem))) {
                Text("\(raindropsItem)")
              }
            }
          }

          Button("1000 might lag", action: {}).disabled(true)

          Divider()

          Button(
            "reset",
            action: {
              settings.rainAmount = 100
            })
        }
      }

      Menu("rain direction") {
        Section(header: Text("rain direction")) {
          Divider()

          Button(action: {
            settings.rainDirection = "right"
          }) {
            Toggle(isOn: .constant(eq(settings.rainDirection, "right"))) {
              Text("left → right")
            }
          }

          Button(action: {
            settings.rainDirection = "left"
          }) {
            Toggle(isOn: .constant(eq(settings.rainDirection, "left"))) {
              Text("right → left")
            }
          }

          Divider()

          Button(
            "reset",
            action: {
              settings.rainDirection = "left"
            })
        }
      }

      Menu("rain opacity") {
        Section(header: Text("rain opacity")) {
          Divider()

          ForEach(Array(stride(from: 10, through: 100, by: 10)), id: \.self) { rainOpacityItem in
            Button(action: {
              settings.rainOpacity = Double(rainOpacityItem) / 100
            }) {
              Toggle(
                isOn: .constant(eq(settings.rainOpacity, Double(rainOpacityItem) / 100))
              ) {
                Text("\(rainOpacityItem)%")
              }
            }
          }

          Divider()

          Button(
            "reset",
            action: {
              settings.rainOpacity = 0.5
            })
        }
      }
    }
  }
}
