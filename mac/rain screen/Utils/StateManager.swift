import SwiftUI

class GlobalStateManager: ObservableObject {
  static let shared: GlobalStateManager = GlobalStateManager()

  @Published var rainAnimation: Bool = UserDefaults.standard.bool(forKey: "rainAnimation") {
    didSet {
      UserDefaults.standard.set(rainAnimation, forKey: "rainAnimation")
    }
  }

  @Published var rainSpeed: Int = UserDefaults.standard.integer(forKey: "rainSpeed") {
    didSet {
      UserDefaults.standard.set(rainSpeed, forKey: "rainSpeed")
    }
  }

  @Published var rainAmount: Int = UserDefaults.standard.integer(forKey: "rainAmount") {
    didSet {
      UserDefaults.standard.set(rainAmount, forKey: "rainAmount")
    }
  }

  @Published var rainDirection: String =
    UserDefaults.standard.string(forKey: "rainDirection") ?? "left"
  {
    didSet {
      UserDefaults.standard.set(rainDirection, forKey: "rainDirection")
    }
  }

  @Published var rainOpacity: Double = UserDefaults.standard.double(forKey: "rainOpacity") {
    didSet {
      UserDefaults.standard.set(rainOpacity, forKey: "rainOpacity")
    }
  }

  @Published var rainSound: Bool = UserDefaults.standard.bool(forKey: "rainSound") {
    didSet {
      UserDefaults.standard.set(rainSound, forKey: "rainSound")
    }
  }

  @Published var rainVolume: Float = UserDefaults.standard.float(forKey: "rainVolume") {
    didSet {
      UserDefaults.standard.set(rainVolume, forKey: "rainVolume")
    }
  }

  @Published var rainSoundWhich: String =
    UserDefaults.standard.string(forKey: "rainSoundWhich") ?? "rain-default.mp3"
  {
    didSet {
      UserDefaults.standard.set(rainSoundWhich, forKey: "rainSoundWhich")
    }
  }

  @Published var useMultipleScreens: Bool =
    UserDefaults.standard.bool(forKey: "useMultipleScreens")
  {
    didSet {
      UserDefaults.standard.set(useMultipleScreens, forKey: "useMultipleScreens")
    }
  }

  @Published var rainSoundCustom: Bool =
    UserDefaults.standard.bool(forKey: "rainSoundCustom")
  {
    didSet {
      UserDefaults.standard.set(rainSoundCustom, forKey: "rainSoundCustom")
    }
  }
}
