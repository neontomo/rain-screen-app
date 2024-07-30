import SwiftUI

func createConfirmPopup(title: String, message: String, action: @escaping () -> Void) {
  let alert = NSAlert()
  alert.messageText = title
  alert.informativeText = message
  alert.alertStyle = .warning

  alert.addButton(withTitle: "ok")
  alert.addButton(withTitle: "cancel")

  let response = alert.runModal()

  switch response {
  case .alertFirstButtonReturn:
    action()
  default:
    print("cancel clicked")
  }
}

func createGenericPopup(title: String, message: String) {
  let alert = NSAlert()
  alert.messageText = title
  alert.informativeText = message
  alert.alertStyle = .informational

  alert.addButton(withTitle: "ok")

  alert.runModal()
}
