//
//  PanelView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/8.
//

import SwiftUI




struct PanelView: View {
    @ObservedObject var profilevm:ProfileViewModel
    @State var isShowingSettingsView:Bool = false
    @State var isShowingProfileDetailView:Bool = false
    
    @State var selectedTab:WellbeingTab = .Career
    var body: some View {
        NavigationView{
            ScrollView(.vertical,showsIndicators: false) {
                
                VStack(alignment: .leading){
                    
                    
                    // MARK: - Wellbeing Index
                    WBScoreView(wbScore: WBScore(dateCreated: Date.now, career: 145, social: 133, physical: 178, financial: 108, community: 89))
                    
                    Text("Principal Component Analysis")
                        .font(.title3.bold())
                        .padding(.top)
                    
                    VStack {
                        NavigationLink {
                            CareerAbstractView()
                        } label: {
                            SettingsRowView(leftIcon: "case", text: "Career", color: .pink)
                        }
                        
                        NavigationLink {
                            SocialAbstractView()
                        } label: {
                            SettingsRowView(leftIcon: "point.3.connected.trianglepath.dotted", text: "Social", color: .pink)
                        }
                        
                        NavigationLink<SettingsRowView, PhysicalAbstractView>{
                            PhysicalAbstractView()
                        } label: {
                            SettingsRowView(leftIcon: "heart.text.square", text: "Physical", color: .pink)
                        }

                        NavigationLink {
                            FinancialAbstractView()
                        } label: {
                            SettingsRowView(leftIcon: "dollarsign.square", text: "Financial", color: .pink)
                        }
                        
                        
                        NavigationLink {
                            CommunityAbstractView()
                            
                        } label: {
                            SettingsRowView(leftIcon: "globe.asia.australia", text: "Community", color: .pink)
                        }
                        
                    }
                    
                    // MARK: - HeatMap
                    
                    Text("Aditional Components")
                        .font(.title3.bold())
                        .padding(.top)
                    
                    
                    NavigationLink {
                        HeatMapView()
                    } label: {
                        SettingsRowView(leftIcon: "map", text: "Range of Activity", color: .pink)
                    }
                    
                    
                    
                    
                    Text("Survey Results")
                        .font(.title3.bold())
                        .padding(.top)
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            NavigationLink {
                                VIAView()
                            } label: {
                                CardView(image: "VIA", title: "VIA Character \nStrength Survey", color: Color.white)
                            }
                            
                            NavigationLink {
                                MBTIView()
                            } label: {
                                CardView(image: "mbti", title: "Myers-Briggs \nType Indicator", color: Color.white)
                            }
                            
                            NavigationLink {
                                BigFiveView()
                            } label: {
                                CardView(image: "bigfive", title: "Big Five \npersonality traits", color: Color.white)
                            }
                        }
                        
                    }
                    
                }
                
            }
            .padding()
            
            .navigationTitle("Dashboard")
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isShowingSettingsView.toggle()
                    } label: {
                        Image(systemName: "gear.circle")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingProfileDetailView.toggle()
                    } label: {
                        ProfileAvatarView(profileImageURL: AppRepoManager.shared.dataStoreRepo.user?.avatarURL)
                    }
                }
            }
            .sheet(isPresented: $isShowingSettingsView) {
                SettingsView(profilevm: profilevm)
            }
            .sheet(isPresented: $isShowingProfileDetailView) {
                ProfileDetailView(profilevm: profilevm)
            }
            .onAppear {
                profilevm.fetchCurrentUser { success in
                    print("successfully fetched current user profile")
                }
            }
            
        }
        //        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct PanelView_Previews: PreviewProvider {
    static var previews: some View {
        PanelView(profilevm: ProfileViewModel())
            .preferredColorScheme(.light)
    }
}


struct TabButton: View{
    @Binding var currentTab: String
    var title: String
    // For bottom indicator slide Animation...
    var animationID: Namespace.ID
    
    var body: some View{
        
        Button {
            
            withAnimation(.spring()){
                currentTab = title
            }
            
        } label: {
            
            VStack{
                
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundColor(currentTab == title ? .black : .gray)
                
                if currentTab == title{
                    Rectangle()
                        .fill(.black)
                        .matchedGeometryEffect(id: "TAB", in: animationID)
                        .frame(width: 50, height: 1)
                }
                else{
                    Rectangle()
                        .fill(.clear)
                        .frame(width: 50, height: 1)
                }
            }
            // Taking Available Width...
            .frame(maxWidth: .infinity)
        }
        
    }
}


// Card View..

struct CardView: View{

    var image:String
    var title:String
//    var price:String
    var color:Color
    
    var body: some View{
        VStack(spacing: 15){
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70)
                .padding()
                .background(color, in: Circle())
            
            Text(title)
                .font(.title3.bold())
                .foregroundColor(.accentColor)
//
//            Text(price)
//                .fontWeight(.semibold)
//                .foregroundColor(.gray)
        }
        .padding(.vertical)
        .padding(.horizontal,25)
        .background(.gray.opacity(0.2),in: RoundedRectangle(cornerRadius: 15))
 
    }
    

}

struct CardView_Previews:PreviewProvider {
    
    static var previews: some View {
        CardView(image: "VIA", title: "Character Strength", color: Color.green)
    }
}


