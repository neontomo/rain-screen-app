import SwiftUI
import UniformTypeIdentifiers

// TODO:
// ideas for sounds:
// wind, fire, forest, ocean, river, waterfall, birds, crickets, frogs, night, train, city, cafe, white noise, pink noise, brown noise, fan, clock, music, ambience silence

struct SoundsSection: View {
  @ObservedObject var settings = SettingsManager.shared

  var rainSounds = [
    "rain-default.mp3": "turqoise",
    "rain-forest.mp3": "wood elves",
    "rain-light.mp3": "tickle",
    "rain-muted.mp3": "muted hope",
    "rain-porch.mp3": "old-timer",
    "rain-window.mp3": "hickory",
  ]

  var thunderSounds = [
    "thunder-brewing.mp3": "brewing",
    "thunder-gods.mp3": "thor's judgement",
    "thunder-nostalgic.mp3": "distant memory",
    "thunder-submerged.mp3": "submerged",
  ]

  var body: some View {
    Section(header: Text("sounds")) {
      Button(action: {
        settings.rainSound.toggle()
      }) {
        Toggle(isOn: .constant(settings.rainSound)) {
          Text("rain sound")
        }.keyboardShortcut("m", modifiers: [.command])
      }

      Menu("sound volume") {
        Section(header: Text("sound volume")) {
          Divider()

          ForEach(Array(stride(from: 10, through: 100, by: 10)), id: \.self) { rainVolumeItem in
            Button(action: {
              settings.rainVolume = rainVolumeItem
            }) {
              Toggle(
                isOn: .constant(eq(settings.rainVolume, rainVolumeItem))
              ) {
                Text("\(Int(rainVolumeItem))%")
              }
            }
          }

          Divider()

          Button(
            "reset",
            action: {
              settings.rainVolume = 30
            })
        }
      }

      Menu("custom sound") {
        Section(header: Text("custom sound")) {
          Divider()

          Button("🌧️ rain only", action: {}).disabled(true)

          ForEach(rainSounds.sorted(by: <), id: \.key) { rainSoundItem in
            Button(action: {
              settings.rainSoundWhich = rainSoundItem.key
              settings.rainSoundCustom = false
            }) {
              Toggle(isOn: .constant(eq(rainSoundItem.key, settings.rainSoundWhich))) {
                Text(rainSoundItem.value)
              }
            }
          }

          Divider()

          Button("⚡️ thunder & rain", action: {}).disabled(true)

          ForEach(thunderSounds.sorted(by: <), id: \.key) { thunderSoundItem in
            Button(action: {
              settings.rainSoundWhich = thunderSoundItem.key
              settings.rainSoundCustom = false
            }) {
              Toggle(isOn: .constant(eq(thunderSoundItem.key, settings.rainSoundWhich))) {
                Text(thunderSoundItem.value)
              }
            }
          }

          Divider()

          Button("your own", action: {}).disabled(true)

          Button(
            "add custom mp3",
            action: {
              openFilePanel()
            })

          Divider()

          Button(
            "reset",
            action: {
              settings.rainSoundWhich = "rain-default.mp3"
              settings.rainSoundCustom = false
            })
        }
      }
    }
  }
}
