import SwiftUI
import UniformTypeIdentifiers

// TODO:
// ideas for sounds:
// wind, fire, forest, ocean, river, waterfall, birds, crickets, frogs, night, train, city, cafe, white noise, pink noise, brown noise, fan, clock, music, ambience silence

func openFilePanel() {
  let dialog = NSOpenPanel()
  dialog.title = "Choose your mp3"
  dialog.showsResizeIndicator = true
  dialog.showsHiddenFiles = false
  dialog.canChooseFiles = true
  dialog.canChooseDirectories = false
  dialog.allowsMultipleSelection = false
  dialog.allowedContentTypes = [UTType.mp3]

  if dialog.runModal() == NSApplication.ModalResponse.OK {
    if let result = dialog.url {
      let fileName = result.lastPathComponent

      let fileManager = FileManager.default
      let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

      let destinationURL = documentsURL.appendingPathComponent(fileName)

      // Check if file already exists at destination
      if fileManager.fileExists(atPath: destinationURL.path) {
        print("file already exists at destination.")

        GlobalStateManager.shared.rainSoundWhich = fileName
        GlobalStateManager.shared.rainSoundCustom = true
      } else {
        do {
          try fileManager.copyItem(at: result, to: destinationURL)
          print("copied to: \(destinationURL)")

          GlobalStateManager.shared.rainSoundWhich = fileName
          GlobalStateManager.shared.rainSoundCustom = true
        } catch {
          createGenericPopup(
            title: "error", message: "could not copy file to the correct location on your computer"
          )
        }
      }
    }
  }
}

struct SoundsSection: View {
  @AppStorage("rainSound") var rainSound = true
  @AppStorage("rainSoundWhich") var rainSoundWhich = "rain-default.mp3"
  @AppStorage("rainVolume") var rainVolume: Double = 0.3

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
      Toggle(isOn: $rainSound) {
        Text("rain sound")
      }.keyboardShortcut("m", modifiers: [.command])

      Menu("sound volume") {
        Section(header: Text("sound volume")) {
          Divider()

          ForEach(Array(stride(from: 10, through: 100, by: 10)), id: \.self) { rainVolumeItem in
            Button(action: {
              GlobalStateManager.shared.rainVolume = Float(rainVolumeItem) / 100
            }) {
              Toggle(isOn: .constant(Float(rainVolume) == Float(rainVolumeItem) / 100)) {
                Text("\(rainVolumeItem)%")
              }
            }
          }

          Divider()

          Button(
            "reset",
            action: {
              GlobalStateManager.shared.rainVolume = 0.3
            })
        }
      }

      Menu("custom sound") {
        Section(header: Text("custom sound")) {
          Divider()

          Button("🌧️ rain only", action: {}).disabled(true)

          ForEach(rainSounds.sorted(by: <), id: \.key) { rainSoundItem in
            Button(action: {
              GlobalStateManager.shared.rainSoundWhich = rainSoundItem.key
              GlobalStateManager.shared.rainSoundCustom = false

            }) {
              Toggle(isOn: .constant(rainSoundItem.key == rainSoundWhich)) {
                Text(rainSoundItem.value)
              }
            }
          }

          Divider()

          Button("⚡️ thunder & rain", action: {}).disabled(true)

          ForEach(thunderSounds.sorted(by: <), id: \.key) { thunderSoundItem in
            Button(action: {
              GlobalStateManager.shared.rainSoundWhich = thunderSoundItem.key
              GlobalStateManager.shared.rainSoundCustom = false
            }) {
              Toggle(isOn: .constant(thunderSoundItem.key == rainSoundWhich)) {
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
              GlobalStateManager.shared.rainSoundWhich = "rain-default.mp3"
              GlobalStateManager.shared.rainSoundCustom = false
            })
        }
      }

    }
  }
}
