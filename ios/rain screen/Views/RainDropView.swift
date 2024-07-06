import SwiftUI

struct RainDrop: View {
  @State public var screenHeight: CGFloat
  @State public var screenWidth: CGFloat
  @State private var position = CGPoint(x: 0, y: 0)
  @State private var movementAngleDegrees: CGFloat = 0

  @AppStorage("rainSpeed") var rainSpeed: Double = 2
  @AppStorage("rainDirection") var rainDirection = "left"
  @AppStorage("rainOpacity") var rainOpacity = 0.5

  private var animation: Animation {
    Animation.linear(duration: Double.random(in: rainSpeed - 0.5...rainSpeed + 0.5))
      .delay(Double.random(in: 0...self.rainSpeed * 2))
      .repeatForever(autoreverses: false)
  }

  private func initializePosition() -> CGPoint {
    let initialX: CGFloat = CGFloat.random(in: -screenWidth * 0.4...screenWidth * 1.4)
    let initialY: CGFloat = -50
    let amountXChange = rainDirection == "left" ? -(screenWidth / 2.5) : (screenWidth / 2.5)
    self.movementAngleDegrees = -atan(amountXChange / (screenHeight * 1.5)) * (180 / .pi)
    return CGPoint(x: initialX, y: initialY)
  }

  private func targetPosition() -> CGPoint {
    let amountXChange = rainDirection == "left" ? -(screenWidth / 2.5) : (screenWidth / 2.5)
    return CGPoint(x: position.x + amountXChange, y: screenHeight * 1.5)
  }

  var body: some View {
    ZStack {
      Capsule()
        .fill(Color.blue)
        .frame(width: 2, height: 8)
        .opacity(rainOpacity)
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
}
