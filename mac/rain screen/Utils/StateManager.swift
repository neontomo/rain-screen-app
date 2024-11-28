import SwiftUI

class SettingsManager: ObservableObject {
  static let shared = SettingsManager()

  @AppStorage("rainAnimation") var rainAnimation: Bool = true
  @AppStorage("rainSpeed") var rainSpeed: Double = 2
  @AppStorage("rainAmount") var rainAmount: Int = 100
  @AppStorage("rainDirection") var rainDirection: String = "left"
  @AppStorage("rainOpacity") var rainOpacity: Double = 0.5
  @AppStorage("useMultipleScreens") var useMultipleScreens: Bool = true
  @AppStorage("rainSound") var rainSound: Bool = true
  @AppStorage("rainSoundWhich") var rainSoundWhich: String = "rain-default.mp3"
  @AppStorage("rainSoundCustom") var rainSoundCustom: Bool = false
  @AppStorage("rainVolume") var rainVolume: Double = 30

  private init() {
    // null
  }

  func resetAllSettings() {
    rainAnimation = true
    rainSpeed = 2
    rainAmount = 100
    rainDirection = "left"
    rainOpacity = 0.5
    useMultipleScreens = true
    rainSound = true
    rainSoundWhich = "rain-default.mp3"
    rainSoundCustom = false
    rainVolume = 30
  }
}
