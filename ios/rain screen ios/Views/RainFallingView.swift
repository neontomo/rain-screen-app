import AVFoundation
import SwiftUI

// music player
class MusicPlayer {
  static var player: AVAudioPlayer?

  static func playMusic(musicfile: String, loops: Int, volume: Double) {
    guard let url = Bundle.main.url(forResource: musicfile, withExtension: nil) else {
      print("file not found")
      return
    }
    do {
      player = try AVAudioPlayer(contentsOf: url)
      player?.numberOfLoops = loops
      player?.volume = Float(volume)
      player?.play()
    } catch {
      print("error playing music")
    }
  }

  static func stopMusic() {
    player?.stop()
  }

  static func setVolume(volume: Double) {
    player?.volume = Float(volume)
  }
}

struct RainFallingView: View {
  // @ObservedObject var globalStateManager = GlobalStateManager.shared
  @State private var renderKey: Int = 0

  @AppStorage("rainSound") var rainSound = true
  @AppStorage("rainSoundWhich") var rainSoundWhich = "rain-turqoise.mp3"
  @AppStorage("rainSoundCustom") var rainSoundCustom = false
  @AppStorage("rainSpeed") var rainSpeed: Double = 2
  @AppStorage("rainDirection") var rainDirection = "left"
  @AppStorage("rainAmount") var rainAmount = 100
  @AppStorage("rainVolume") var rainVolume: Double = 0.3
  @AppStorage("rainOpacity") var rainOpacity = 0.3

  func handleMusicChange(rainSound: Bool, musicFile: String, volume: Double) {
    if rainSound {
      MusicPlayer.playMusic(musicfile: musicFile, loops: -1, volume: volume)
    } else {
      MusicPlayer.stopMusic()
    }
  }

  var body: some View {
    GeometryReader { geometry in
      ZStack {
        ForEach(0...rainAmount, id: \.self) { index in
          RainDrop(
            screenHeight: geometry.size.height,
            screenWidth: geometry.size.width
          )
        }
      }.id(renderKey)
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
  }
}
