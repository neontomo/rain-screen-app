import AVFoundation
import SwiftUI

class MusicPlayer {
  static var audioPlayer: AVAudioPlayer?

  static func playMusic(
    musicfile: String,
    loops: Int = -1,
    volume: Double = 1.0
  ) {
    @AppStorage("rainSound") var rainSound: Bool = true
    @AppStorage("rainSoundCustom") var rainSoundCustom = false

    if rainSoundCustom {
      let fileManager = FileManager.default
      let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
      let fileURL = documentsURL.appendingPathComponent(musicfile)

      do {
        audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
        audioPlayer?.numberOfLoops = loops
        audioPlayer?.volume = Float(volume)
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()

      } catch {
        createGenericPopup(title: "error", message: "could not play sound file")
      }
      return
    } else {

      if let path = Bundle.main.path(forResource: musicfile, ofType: nil) {
        do {
          if rainSound {
            #if canImport(UIKit)
              try AVAudioSession.sharedInstance().setCategory(.playback)
              try AVAudioSession.sharedInstance().setActive(true)
            #endif
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.numberOfLoops = loops
            audioPlayer?.volume = Float(volume)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
          }
        } catch {
          createGenericPopup(title: "error", message: "could not play sound file")
        }
      } else {
        createGenericPopup(title: "error", message: "could not find sound file")
      }
    }
  }

  static func stopMusic() {
    audioPlayer?.stop()
  }

  static func setVolume(volume: Double) {
    audioPlayer?.volume = Float(volume)
  }
}
