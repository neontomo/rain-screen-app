//
//  SplashView.swift
//  rain screen ios
//
//  Created by Tomo Myrman on 2024-07-20.
//

import SwiftUI

struct SplashView: View {
  var body: some View {
    Text("rain screen")
      .font(.largeTitle)
      .fontWeight(.bold)
      .foregroundColor(.white)
      .padding()
    Text("tap for settings")
      .font(.title)
      .foregroundColor(.white)
      .padding()
  }
}

#Preview {
  SplashView()
}
