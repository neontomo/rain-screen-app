import SwiftUI

struct CustomisationsSection: View {
  @AppStorage("rainAnimation") var rainAnimation = true
  @AppStorage("rainSpeed") var rainSpeed: Double = 2
  @AppStorage("rainAmount") var rainAmount = 100
  @AppStorage("rainDirection") var rainDirection = "left"
  @AppStorage("rainOpacity") var rainOpacity = 0.5

  var body: some View {
    Section(header: Text("customisations")) {
      Toggle(isOn: $rainAnimation) {
        Text("rain animation")
      }.keyboardShortcut("a", modifiers: [.command])

      Menu("rain speed") {
        Section(header: Text("rain speed")) {
          Divider()

          ForEach(1...10, id: \.self) { rainSpeedItem in
            Button(action: {
              GlobalStateManager.shared.rainSpeed = rainSpeedItem
            }) {
              Toggle(isOn: .constant(Int(rainSpeed) == Int(rainSpeedItem))) {
                Text("\(rainSpeedItem)s")
              }
            }
          }

          Divider()

          Button(
            "reset",
            action: {
              GlobalStateManager.shared.rainSpeed = 2
            })
        }
      }

      Menu("raindrops amount") {
        Section(header: Text("raindrops amount")) {
          Divider()

          ForEach([50, 100, 200, 300, 400, 500, 1000], id: \.self) { raindropsItem in
            Button(action: {
              GlobalStateManager.shared.rainAmount = raindropsItem
            }) {
              Toggle(isOn: .constant(rainAmount == raindropsItem)) {
                Text("\(raindropsItem)")
              }
            }
          }

          Button("1000 might lag", action: {}).disabled(true)

          Divider()

          Button(
            "reset",
            action: {
              GlobalStateManager.shared.rainAmount = 100
            })
        }
      }

      Menu("rain direction") {
        Section(header: Text("rain direction")) {
          Divider()

          Button(action: {
            GlobalStateManager.shared.rainDirection = "right"
          }) {
            Toggle(isOn: .constant(rainDirection == "right")) {
              Text("left → right")
            }
          }

          Button(action: {
            GlobalStateManager.shared.rainDirection = "left"
          }) {
            Toggle(isOn: .constant(rainDirection == "left")) {
              Text("right → left")
            }
          }

          Divider()

          Button(
            "reset",
            action: {
              GlobalStateManager.shared.rainDirection = "left"
            })
        }
      }

      Menu("rain opacity") {
        Section(header: Text("rain opacity")) {
          Divider()

          ForEach(Array(stride(from: 10, through: 100, by: 10)), id: \.self) { rainOpacityItem in
            Button(action: {
              GlobalStateManager.shared.rainOpacity = Double(rainOpacityItem) / 100
            }) {
              Toggle(isOn: .constant(rainOpacity == Double(rainOpacityItem) / 100)) {
                Text("\(rainOpacityItem)%")
              }
            }
          }

          Divider()

          Button(
            "reset",
            action: {
              GlobalStateManager.shared.rainOpacity = 0.5
            })
        }
      }
    }
  }
}
