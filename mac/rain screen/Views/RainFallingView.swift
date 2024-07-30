import SwiftUI

struct RainFallingView: View {
  // @ObservedObject var globalStateManager = GlobalStateManager.shared
  @State private var renderKey: Int = 0

  @AppStorage("rainAnimation") var rainAnimation = true
  @AppStorage("rainSound") var rainSound = true
  @AppStorage("rainSoundWhich") var rainSoundWhich = "rain-default.mp3"
  @AppStorage("rainSoundCustom") var rainSoundCustom = false
  @AppStorage("rainSpeed") var rainSpeed: Double = 2
  @AppStorage("rainDirection") var rainDirection = "left"
  @AppStorage("rainAmount") var rainAmount = 100
  @AppStorage("rainVolume") var rainVolume: Double = 0.3
  @AppStorage("rainOpacity") var rainOpacity = 0.5

  func handleMusicChange(rainSound: Bool, musicFile: String, volume: Double) {
    if rainSound {
      MusicPlayer.playMusic(musicfile: musicFile, loops: -1, volume: volume)
    } else {
      MusicPlayer.stopMusic()
    }
  }

  var body: some View {
    GeometryReader { geometry in
      if rainAnimation {
        ZStack {
          ForEach(0...rainAmount, id: \.self) { index in
            RainDrop(
              screenHeight: geometry.size.height,
              screenWidth: geometry.size.width
            )
          }
        }.id(renderKey)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .drawingGroup()
    .edgesIgnoringSafeArea(.all)
    .onAppear {
      handleMusicChange(rainSound: rainSound, musicFile: rainSoundWhich, volume: rainVolume)
    }
    .onChange(of: rainSound) {
      handleMusicChange(rainSound: rainSound, musicFile: rainSoundWhich, volume: rainVolume)
    }
    .onChange(of: rainSoundWhich) {
      handleMusicChange(rainSound: rainSound, musicFile: rainSoundWhich, volume: rainVolume)
    }
    .onChange(of: rainVolume) {
      MusicPlayer.setVolume(volume: rainVolume)
    }
    .onChange(of: [rainSpeed, rainOpacity]) {  // doubles
      renderKey += 1
      print("increasing render key because of rainSpeed or rainOpacity")
    }
    .onChange(of: [rainAmount]) {  // integers
      renderKey += 1
      print("increasing render key because of rainAmount")
    }
    .onChange(of: rainDirection) {  // strings
      renderKey += 1
      print("increasing render key because of rainDirection")
    }
    .onChange(of: rainAnimation) {  // bool
      renderKey += 1
      print("increasing render key because of rainDirection")
    }
  }
}
