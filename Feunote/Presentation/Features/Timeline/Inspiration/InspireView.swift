//
//  InspireView.swift
//  Beliski (iOS)
//
//  Created by Losd wind on 2021/11/12.
//

import SwiftUI

struct InspireView: View {
    @ObservedObject var profilevm:ProfileViewModel

    var body: some View {
       
            ScrollView(.vertical, showsIndicators: false){
                        VStack{
                            
                            NavigationLink {
                                WordCloudView()
                            } label: {
                                SettingsRowView(leftIcon: "lightbulb.circle", text: "Word Cloud", color: Color.pink)
                            }
                            
                            NavigationLink {
                                LinkNetworkView()
                            } label: {
                                SettingsRowView(leftIcon: "network", text: "Link Network", color: Color.pink)
                            }


                       
                            NavigationLink {
                                AllTagsView()
                            } label: {
                                SettingsRowView(leftIcon: "number.circle", text: "All Tags", color: Color.pink)
                            }

                            
                            
                            NavigationLink {
                                MediaFileView()
                            } label: {
                                SettingsRowView(leftIcon: "paperclip.circle", text: "Media File", color: Color.pink)
                            }

                            
                            Divider()
                            NavigationLink {
                                MainThreadView()
                            } label: {
                                SettingsRowView(leftIcon: "wind", text: "Main Threads", color: Color.pink)
                            }

                            
                            NavigationLink {
                                HiddenClueView()
                            } label: {
                                SettingsRowView(leftIcon: "waveform.and.magnifyingglass", text: "Hidden Clues", color: Color.pink)
                            }

                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    
                }
            .navigationTitle("Inspirations")
            
        }
    }

struct InspireView_Previews: PreviewProvider {
    static var previews: some View {
        InspireView(profilevm: ProfileViewModel())
    }
}
