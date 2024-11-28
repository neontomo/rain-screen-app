import SwiftUI

struct RainDropGroup: View {
  @StateObject var settings = SettingsManager.shared
  @State private var yOffset: CGFloat = -50
  @State private var xOffset: CGFloat = 0
  let screenHeight: CGFloat
  let screenWidth: CGFloat
  let groupId: Int

  private var animation: Animation {
    Animation.linear(
      duration: Double.random(
        in: (settings.rainSpeed - 0.5)...(settings.rainSpeed + 0.5)
      )
    )
    .delay(Double.random(in: 0...settings.rainSpeed * 5))
    .repeatForever(autoreverses: false)
  }

  private var movementAngleDegrees: CGFloat {
    let amountXChange =
      settings.rainDirection == "left" ? -(screenWidth / 2.5) : (screenWidth / 2.5)
    return -atan(amountXChange / (screenHeight * 1.5)) * (180 / .pi)
  }

  var body: some View {
    Path { path in
      for _ in 0..<5 {
        let extraOffset = abs(screenWidth / 2.5 * sin(movementAngleDegrees * .pi / 180))
        let x = CGFloat.random(in: -screenWidth * 0.6...screenWidth * 1.6)
        let y = CGFloat.random(in: -(100 + extraOffset)...(-(100 + extraOffset)))
        path.move(to: CGPoint(x: x, y: y))
        path.addLine(to: CGPoint(x: x, y: y + 8))
      }
    }
    .stroke(Color.blue, lineWidth: 2)
    .opacity(Double.random(in: settings.rainOpacity - 0.5...settings.rainOpacity + 0.5))
    .rotationEffect(.degrees(movementAngleDegrees))
    .offset(x: xOffset, y: yOffset)
    .onAppear {
      let amountXChange =
        settings.rainDirection == "left" ? -(screenWidth / 2.5) : (screenWidth / 2.5)

      withAnimation(animation) {
        yOffset = screenHeight * 1.5
        xOffset = amountXChange
      }
    }
  }
}

// OLD CODE:
/* struct RainDrop: View {
  @StateObject var settings = SettingsManager.shared
  @State public var screenHeight: CGFloat
  @State public var screenWidth: CGFloat
  @State private var position = CGPoint(x: 0, y: 0)
  @State private var movementAngleDegrees: CGFloat = 0

  private var animation: Animation {
    Animation.linear(
      duration: Double.random(in: settings.rainSpeed - 0.5...settings.rainSpeed + 0.5)
    )
    .delay(Double.random(in: 0...settings.rainSpeed * 2))
    .repeatForever(autoreverses: false)
  }

  private func initializePosition() -> CGPoint {
    let initialX: CGFloat = CGFloat.random(in: -screenWidth * 0.4...screenWidth * 1.4)
    let initialY: CGFloat = -50
    let amountXChange =
      settings.rainDirection == "left" ? -(screenWidth / 2.5) : (screenWidth / 2.5)
    self.movementAngleDegrees = -atan(amountXChange / (screenHeight * 1.5)) * (180 / .pi)
    return CGPoint(x: initialX, y: initialY)
  }

  private func targetPosition() -> CGPoint {
    let amountXChange =
      settings.rainDirection == "left" ? -(screenWidth / 2.5) : (screenWidth / 2.5)
    return CGPoint(x: position.x + amountXChange, y: screenHeight * 1.5)
  }

  var body: some View {
    ZStack {
      Capsule()
        .fill(Color.blue)
        .frame(width: 2, height: 8)
        .opacity(settings.rainOpacity)
        .rotationEffect(.degrees(self.movementAngleDegrees))
    }
    .position(position)
    .onAppear {
      position = self.initializePosition()
      withAnimation(self.animation) {
        position = self.targetPosition()
      }
    }
  }
} */
