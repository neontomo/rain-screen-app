import PhotosUI
import StoreKit
import SwiftUI

/*

TODO:

later:

- later: refactor code/views
- add review to stimulated + perhaps rain screen macos
*/

func openURL(_ urlString: String) {
  guard let url = URL(string: urlString) else {
    print("Invalid URL")
    return
  }

  DispatchQueue.main.async {
    UIApplication.shared.open(url, options: [:]) { success in
      if success {
        print("URL successfully opened")
      } else {
        print("Failed to open URL")
      }
    }
  }
}

struct Wallpaper: View {
  @AppStorage("wallpaper") var wallpaper = "wallpaper-hd"

  var body: some View {
    if let imageData = Data(base64Encoded: wallpaper),
      let uiImage = UIImage(data: imageData)
    {
      Image(uiImage: uiImage)
        .resizable()
        .scaledToFill()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .overlay(
          Color.black.opacity(0.4)
        )
    } else {
      Image("wallpaper-hd")
        .resizable()
        .scaledToFill()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .overlay(
          Color.black.opacity(0.4)
        )
    }
  }
}

struct WallpaperButton: View {
  @AppStorage("wallpaper") var wallpaper = "wallpaper-hd"
  @State private var photosPickerPresented = false
  @State var selectedItem: PhotosPickerItem?

  var body: some View {
    Button("\(wallpaper == "wallpaper-hd" ? "default" : "custom")") {
      photosPickerPresented = true
    }
    .foregroundColor(.blue)
    .photosPicker(
      isPresented: $photosPickerPresented,
      selection: $selectedItem
    )
    .onChange(of: selectedItem) { newItem in
      if let item = newItem {
        item.loadTransferable(type: Data.self) { result in
          switch result {
          case .success(let data):
            if let data = data, let uiImage = UIImage(data: data) {
              wallpaper = data.base64EncodedString()
              // print("wallpaper: \(wallpaper)")
            }
          case .failure(let error):
            print("Error loading image: \(error.localizedDescription)")
          }
        }
      }
    }
  }
}

struct SettingsView: View {
  @Environment(\.requestReview) var requestReview
  @Binding var isPresented: Bool

  @AppStorage("rainSound") var rainSound = true
  @AppStorage("rainSoundWhich") var rainSoundWhich = "rain-turqoise.mp3"
  @AppStorage("rainSpeed") var rainSpeed: Double = 2
  @AppStorage("rainDirection") var rainDirection = "left"
  @AppStorage("rainAmount") var rainAmount = 100
  @AppStorage("rainVolume") var rainVolume: Double = 0.3
  @AppStorage("rainOpacity") var rainOpacity = 0.3
  @AppStorage("wallpaper") var wallpaper = "wallpaper-hd"

  var rainSounds = [
    "rain-turqoise.mp3": "turqoise",
    "rain-wood-elves.mp3": "wood elves",
    "rain-tickle.mp3": "tickle",
    "rain-muted-hope.mp3": "muted hope",
    "rain-old-timer.mp3": "old-timer",
    "rain-hickory.mp3": "hickory",
  ]

  var thunderSounds = [
    "thunder-brewing.mp3": "brewing",
    "thunder-thors-judgement.mp3": "thors judgement",
    "thunder-distant-memory.mp3": "distant memory",
    "thunder-submerged.mp3": "submerged",
  ]

  var body: some View {
    ZStack {
      Color.black
        .edgesIgnoringSafeArea(.all)
      VStack {
        Text("settings")
          .font(.title2)
          .fontWeight(.bold)
          .foregroundColor(.white)

        Spacer()

        Form {
          Section(header: Text("sound").foregroundColor(.white)) {
            Toggle("rain sound", isOn: $rainSound)
              .toggleStyle(SwitchToggleStyle(tint: .blue))

            LabeledContent("volume") {
              Menu {  // sound volume
                ForEach(Array(stride(from: 10, through: 100, by: 10)), id: \.self) {
                  rainVolumeItem in
                  Button(action: {
                    rainVolume = Double(rainVolumeItem) / 100
                  }) {
                    Toggle(isOn: .constant(Float(rainVolume) == Float(rainVolumeItem) / 100)) {
                      Text("\(rainVolumeItem)%")
                    }
                  }
                }

              } label: {
                Text("\(Int(rainVolume * 100))%")
                  .foregroundColor(.blue)
              }.listRowBackground(Color.black)
            }

            LabeledContent("pick sound") {
              Menu {  // custom sound
                Button("🌧️ rain only", action: {}).disabled(true)
                ForEach(rainSounds.sorted(by: <), id: \.key) { rainSoundItem in
                  Button(action: {
                    rainSoundWhich = rainSoundItem.key
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
                    rainSoundWhich = thunderSoundItem.key
                  }) {
                    Toggle(isOn: .constant(thunderSoundItem.key == rainSoundWhich)) {
                      Text(thunderSoundItem.value)
                    }
                  }
                }

              } label: {
                let formattedSoundName =
                  rainSoundWhich
                  .replacingOccurrences(of: "rain-", with: "")
                  .replacingOccurrences(of: "thunder-", with: "")
                  .replacingOccurrences(of: ".mp3", with: "")
                  .replacingOccurrences(of: "-", with: " ")

                Text("\(formattedSoundName)")
                  .foregroundColor(.blue)
              }.listRowBackground(Color.black)
            }
          }.listRowBackground(Color(red: 0.1, green: 0.1, blue: 0.1))

          Section(header: Text("customisations").foregroundColor(.white)) {
            LabeledContent("wallpaper") {
              WallpaperButton()
            }
            Button("reset wallpaper") {
              wallpaper = "wallpaper-hd"
            }.foregroundColor(.red)

            LabeledContent("rain speed") {
              Menu {  // rain speed
                ForEach(1...10, id: \.self) { rainSpeedItem in
                  Button(action: {
                    rainSpeed = Double(rainSpeedItem)
                  }) {
                    Toggle(isOn: .constant(Int(rainSpeed) == Int(rainSpeedItem))) {
                      Text("\(rainSpeedItem)s")
                    }
                  }
                }
              } label: {
                Text("\(Int(rainSpeed))s")
                  .foregroundColor(.blue)
              }
            }

            LabeledContent("rain amount") {
              Menu {  // rain amount
                ForEach([50, 100, 150, 200, 250, 300], id: \.self) { raindropsItem in
                  Button(action: {
                    rainAmount = raindropsItem
                  }) {
                    Toggle(isOn: .constant(rainAmount == raindropsItem)) {
                      Text("\(raindropsItem)")
                    }
                  }
                }
              } label: {
                Text("\(Int(rainAmount))")
                  .foregroundColor(.blue)
              }
            }

            LabeledContent("rain direction") {
              Button("\(rainDirection == "left" ? "right → left": "left → right")") {
                rainDirection = rainDirection == "left" ? "right" : "left"
              }
              .foregroundColor(.blue)
            }

            LabeledContent("rain opacity") {
              Menu {  // rain opacity
                ForEach(Array(stride(from: 10, through: 100, by: 10)), id: \.self) {
                  rainOpacityItem in
                  Button(action: {
                    rainOpacity = Double(rainOpacityItem) / 100
                  }) {
                    Toggle(isOn: .constant(rainOpacity == Double(rainOpacityItem) / 100)) {
                      Text("\(rainOpacityItem)%")
                    }
                  }
                }
              } label: {
                Text("\(Int(rainOpacity * 100))%")
                  .foregroundColor(.blue)
              }
            }
          }.listRowBackground(Color(red: 0.1, green: 0.1, blue: 0.1))

          Section(header: Text("about").foregroundColor(.white)) {
            Button("rain screen website ↗") {
              openURL("https://rain-screen.netlify.app")
            }.foregroundColor(.blue)

            Button("leave rating ⭐︎") {
              requestReview()
            }.foregroundColor(.blue)

            Button("leave review ↗") {
              openURL("https://apps.apple.com/app/id6572311975?action=write-review")
            }.foregroundColor(.blue)

            Button("my other projects ↗") {
              openURL("https://neontomo.com")
            }.foregroundColor(.blue)

            Text("by Tomo Myrman")
              .foregroundColor(.gray)

          }.listRowBackground(Color(red: 0.1, green: 0.1, blue: 0.1))

        }
        .scrollContentBackground(.hidden)
        .foregroundColor(.white)

        Spacer()

        HStack {
          Button("reset") {
            rainSound = true
            rainSoundWhich = "rain-turqoise.mp3"
            rainSpeed = 2
            rainDirection = "left"
            rainAmount = 100
            rainVolume = 0.3
            rainOpacity = 0.3
            wallpaper = "wallpaper-hd"
          }
          .foregroundColor(.red)
          .padding()

          Button("Save") {
            isPresented = false
          }
          .padding()
          .background(Color.white)
          .cornerRadius(10)
        }
      }
    }
  }
}

struct ContentView: View {
  @Environment(\.requestReview) var requestReview
  @AppStorage("hasLeftReview") var hasLeftReview = false

  @State private var showSplash = true
  @State private var showSettings = false

  var body: some View {
    Wallpaper()
      .overlay(
        RainFallingView()
      )
      .onTapGesture {
        showSettings = true
      }
      .overlay(
        VStack {
          if showSplash {
            SplashView()
          }
        }
      )
      .contentShape(Rectangle())  // disable touch
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
          withAnimation {
            showSplash = false
          }
        }
        if !hasLeftReview {  // 5min
          DispatchQueue.main.asyncAfter(deadline: .now() + 300) {
            requestReview()
            hasLeftReview = true
          }
        }
      }
      .fullScreenCover(isPresented: $showSettings) {
        SettingsView(isPresented: $showSettings)
      }
  }
}

#Preview {
  ContentView()
}
