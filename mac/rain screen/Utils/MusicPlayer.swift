import AVFoundation
import SwiftUI

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

        SettingsManager.shared.rainSoundWhich = fileName
        SettingsManager.shared.rainSoundCustom = true
      } else {
        do {
          try fileManager.copyItem(at: result, to: destinationURL)
          print("copied to: \(destinationURL)")

          SettingsManager.shared.rainSoundWhich = fileName
          SettingsManager.shared.rainSoundCustom = true
        } catch {
          createGenericPopup(
            title: "error", message: "could not copy file to the correct location on your computer"
          )
        }
      }
    }
  }
}

class MusicPlayer {
  static var audioPlayer: AVAudioPlayer?

  static func playMusic(
    musicfile: String,
    loops: Int = -1,
    volume: Double = 100
  ) {
    if SettingsManager.shared.rainSoundCustom {
      let fileManager = FileManager.default
      let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
      let fileURL = documentsURL.appendingPathComponent(musicfile)

      do {
        audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
        audioPlayer?.numberOfLoops = loops
        audioPlayer?.volume = Float(volume) / 100
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()

      } catch {
        createGenericPopup(title: "error", message: "could not play sound file")
      }
      return
    } else {

      if let path = Bundle.main.path(forResource: musicfile, ofType: nil) {
        do {
          if SettingsManager.shared.rainSound {
            #if canImport(UIKit)
              try AVAudioSession.sharedInstance().setCategory(.playback)
              try AVAudioSession.sharedInstance().setActive(true)
            #endif
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.numberOfLoops = loops
            audioPlayer?.volume = Float(volume) / 100
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

  static func updateMusic() {
    @ObservedObject var settings = SettingsManager.shared

    if SettingsManager.shared.rainSound {
      MusicPlayer.playMusic(
        musicfile: settings.rainSoundWhich,
        loops: -1,
        volume: settings.rainVolume
      )
    } else {
      audioPlayer?.stop()
    }
  }

  static func updateVolume() {
    @ObservedObject var settings = SettingsManager.shared

    audioPlayer?.volume = Float(settings.rainVolume) / 100
  }

  static func stopMusic() {
    audioPlayer?.stop()
  }
}
