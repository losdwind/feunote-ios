//
//  InspireView.swift
//  Beliski (iOS)
//
//  Created by Losd wind on 2021/11/12.
//

import SwiftUI

struct InspireView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
//                    Label {
//                        Text("Stats")
//                            .font(.ewHeadline)
//
//
//                    } icon: {
//                        Image(systemName: "doc.append")
//                    }

                StatsBarsView()

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
                    SettingsRowView(leftIcon: "number.circle", text: "Extracted Tags", color: Color.pink)
                }


                NavigationLink {
                    MediaFileView()
                } label: {
                    SettingsRowView(leftIcon: "paperclip.circle", text: "Media File", color: Color.pink)
                }

                //
                //                    Label {
                //                        Text("Predictions")
                //                            .font(.ewHeadline)
                //                    } icon: {
                //                        Image(systemName: "function")
                //                    }
                Divider()

                NavigationLink {
                    MainThreadView()
                } label: {
                    SettingsRowView(leftIcon: "wind", text: "Meta Topics", color: Color.pink)
                }

                NavigationLink {
                    HiddenClueView()
                } label: {
                    SettingsRowView(leftIcon: "waveform.and.magnifyingglass", text: "Niche Point", color: Color.pink)
                }
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image("arrow-left-2")
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Inspirations")
                    .font(.ewHeadline)
                    .foregroundColor(.ewBlack)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct InspireView_Previews: PreviewProvider {
    static var previews: some View {
        InspireView()
    }
}
