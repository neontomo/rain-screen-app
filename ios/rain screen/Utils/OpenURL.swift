import SwiftUI

func openURL(_ urlString: String) {
  guard let url = URL(string: urlString) else {
    print("Invalid URL")
    return
  }

  NSWorkspace.shared.open(url)
}
