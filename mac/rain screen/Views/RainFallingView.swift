import SwiftUI

struct RainFallingView: View {
  @StateObject var settings = SettingsManager.shared
  @State private var renderKey: Int = 0

  private var numberOfGroups: Int {
    max(1, settings.rainAmount / 5)
  }

  private struct RainSettings: Equatable {
    let speed: Double
    let opacity: Double
    let amount: Int
    let direction: String
    let animation: Bool
  }

  private struct MusicSettings: Equatable {
    let rainSound: Bool
    let rainSoundWhich: String
  }

  private var currentMusicSettings: MusicSettings {
    MusicSettings(
      rainSound: settings.rainSound,
      rainSoundWhich: settings.rainSoundWhich
    )
  }

  private var currentRainSettings: RainSettings {
    RainSettings(
      speed: settings.rainSpeed,
      opacity: settings.rainOpacity,
      amount: settings.rainAmount,
      direction: settings.rainDirection,
      animation: settings.rainAnimation
    )
  }

  var body: some View {
    GeometryReader { geometry in
      if settings.rainAnimation {
        LazyVStack(spacing: 0) {
          ZStack {
            ForEach(0..<numberOfGroups, id: \.self) { index in
              RainDropGroup(
                screenHeight: geometry.size.height,
                screenWidth: geometry.size.width,
                groupId: index
              )
            }
          }
        }
        .id(renderKey)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .drawingGroup()
    .edgesIgnoringSafeArea(.all)
    .onAppear {
      MusicPlayer.updateMusic()
    }
    .onChange(of: currentMusicSettings) { oldValue, newValue in
      MusicPlayer.updateMusic()
    }
    .onChange(of: settings.rainVolume) {
      MusicPlayer.updateVolume()
    }
    .onChange(of: currentRainSettings) { oldValue, newValue in
      renderKey += 1
    }
  }
}
