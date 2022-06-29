//
//  BlankView.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/24.
//

import SwiftUI

struct BlankView: View {
  // MARK: - PROPERTY
  
  var backgroundColor: Color
  var backgroundOpacity: Double
  
  // MARK: - BODY
  
  var body: some View {
    VStack {
      Spacer()
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    .background(backgroundColor)
    .opacity(backgroundOpacity)
    .blendMode(.overlay)
    .edgesIgnoringSafeArea(.all)
  }
}

// MARK: - PREVIEW

struct BlankView_Previews: PreviewProvider {
  static var previews: some View {
    BlankView(backgroundColor: Color.black, backgroundOpacity: 0.3)

  }
}
