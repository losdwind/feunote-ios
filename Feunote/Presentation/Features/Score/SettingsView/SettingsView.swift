//
//  SettingsView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/26.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var profilevm: ProfileViewModel
    @EnvironmentObject var authvm:AuthViewModel
    @State var showSignOutError: Bool = false
    
    
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false, content: {
                
                // MARK: SECTION 1: Beliski
                GroupBox(label: SettingsLabelView(labelText: "Feunotes", labelImage: "dot.radiowaves.left.and.right"), content: {
                    HStack(alignment: .center, spacing: 10, content: {
                        
                        
                        Text("Feunote is a research-based human behavior analysis and mobile sensing app. It uses professional tools to extract user patterns from a variety of sources, including the user's social-economic attributes, self-generated rich-media materials, health datastream, daily activities and environmental backgrounds. Its goal is to help users to achieve and maintain eudaimonic wellbeing throughout their lives.")
                            .font(.ewFootnote)
                            .foregroundColor(.ewBlack)
                        
                    })
                })
                
                // MARK: SECTION 2: PROFILE
                GroupBox(label: SettingsLabelView(labelText: "Profile", labelImage: "person"), content: {
                    
                    NavigationLink(
                        destination: PrivateEditorView(profilevm: profilevm),
                        label: {
                            SettingsRowView(leftIcon: "person.circle", text: "Profile Info", color: Color.pink)
                        })
                    
                    
                    Button(action: {
                        
                        Task{
                            presentationMode.wrappedValue.dismiss()
                            await authvm.signOut()
                        }
                        

                    }, label: {
                        SettingsRowView(leftIcon: "figure.walk", text: "Sign out", color: Color.pink)
                    })
                    .alert(isPresented: $showSignOutError, content: {
                        return Alert(title: Text("Error signing out 🥵"))
                    })

                    
                })
                
                
                // MARK: SECTION 3: Notification
                GroupBox(label: SettingsLabelView(labelText: "Notification", labelImage: "bell"), content: {
                    
                    SettingRowToggle(leftIcon: "bell", text: "New Group Message", color: Color.pink, toggleState: $profilevm.settings.notificationFromGroupMessage)
                    

                    
                })
                
                // MARK: SECTION 3: APPLICATION Relevant
                GroupBox(label: SettingsLabelView(labelText: "Application", labelImage: "apps.iphone"), content: {
                    
                    
                    Button(action: {
                        openCustomURL(urlString: "https://www.google.com")
                    }, label: {
                        SettingsRowView(leftIcon: "folder.fill", text: "Privacy Policy", color: Color.white)
                    })
                    
                    Button(action: {
                        openCustomURL(urlString: "https://www.yahoo.com")
                    }, label: {
                        SettingsRowView(leftIcon: "folder.fill", text: "Terms & Conditions", color: Color.white)
                    })
                    
                    Button(action: {
                        openCustomURL(urlString: "https://www.bing.com")
                    }, label: {
                        SettingsRowView(leftIcon: "globe", text: "Figurich's Website", color: Color.white)
                    })

                })
                
                // MARK: SECTION 4: Footer
                GroupBox {
                    Text("Feunote is made with love. \n All Rights Reserved \n Figurich Inc. \n Copyright 2020 ♥️")
                        .font(.ewFootnote)
                        .foregroundColor(.ewGray900)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                    
                }
                .background(Color.ewGray50)
                .padding(.bottom, 80)
                
            })
            .navigationBarTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:
                                    Button(action: {
                                        presentationMode.wrappedValue.dismiss()
                                    }, label: {
                                        Image("arrow-left-2")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 14, height: 14)
                                    })
                                        .foregroundColor(.ewBlack)
            )
            .padding()
        }

    }
    
    // MARK: FUNCTIONS
    
    func openCustomURL(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    
}

struct SettingsView_Previews: PreviewProvider {

    
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.dark)
    }
}
