//
//  NavigationBars.swift
//  BricksUI
//
//  Copyright © 2020 by a cool group. All rights reserved.
//

import SwiftUI


struct EWNavigatorTop: View {
    
    var title : String
    var subtitle: String = ""
    var leftIconString: String
    var rightIconStrings : [String]
    var buttonCommits : [()->()] = [{}, {}, {}]
    
    var body: some View {
        
        HStack {
            Group {
                Button(action:
                    self.buttonCommits[0]
                ) {
                    HStack(spacing: 0) {
                        Image(systemName: self.leftIconString)
                            .ewSquare(width: 24)
                            .padding(.horizontal, 4)
                    }
                }
                .buttonStyle(LeftNavButtonStyle())
                Spacer()
                
                VStack {
                    Text(self.title).ewTypo(.h5, color: .black).offset(y: self.subtitle == "" ? 5: 0)
                    Text(self.subtitle).ewTypo(.p2, color: .ewBasic).padding(.top, self.subtitle == "" ? 0: 5)
                }
                .offset(x: 23, y: 0)
                
                Spacer()
                
                HStack(spacing: 22){
                    Button(action: self.buttonCommits[1]) {
                        Image(systemName: self.rightIconStrings[0])
                            .ewSquare(width: 24)
                    }
                    Button(action: self.buttonCommits[2]) {
                        Image(systemName: self.rightIconStrings[1])
                            .ewSquare(width: 24)
                    }
                }
                .buttonStyle(RightNavButtonStyle())
                .padding(.horizontal, 4)
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
        .background(Color.ewBackground)
        .clipped()
        .shadow(color: Color.ewBasic, radius: 3, x: 0, y: 0)
        .animation(.default)
    }
    
}

struct RightNavButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color.ewPrimary: Color.ewBasic)
    }
}

struct LeftNavButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color.ewPrimary: Color.black)
    }
}



struct EWNavigatorTop_Previews: PreviewProvider {
    static var previews: some View {
        
        VStack() {
            
            EWNavigatorTop(title: "BricksUI", subtitle: "A Cool Group", leftIconString: "arrow.left", rightIconStrings: ["star", "heart"])

            Spacer()
        }
        .edgesIgnoringSafeArea(.horizontal)
        .edgesIgnoringSafeArea(.top)
    }
}

