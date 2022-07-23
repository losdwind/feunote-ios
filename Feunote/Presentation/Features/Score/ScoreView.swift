//
//  PanelView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/8.
//

import SwiftUI


struct ScoreView: View {
    @EnvironmentObject var profilevm:ProfileViewModel
    @EnvironmentObject var authvm:AuthViewModel
    @State var isShowingSettingsView:Bool = false
    @State var isShowingProfileDetailView:Bool = false
    
    @State var selectedTab:WellbeingTab = .Career
    var body: some View {
            ScrollView(.vertical,showsIndicators: false) {
                
                LazyVStack(alignment: .leading, spacing: .ewPaddingHorizontalLarge){
                    
                    
                    // MARK: - Wellbeing Index
                    WBScoreView(wbScore: WBScore(dateCreated: Date(), career: 145/200, social: 133/200, physical: 178/200, financial: 108/200, community: 89/200))

                    SensorView()
                    
                    SurveyView()
                    
                }
                
            }
            .padding()
            
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingSettingsView.toggle()
                    } label: {
                        Image("settings")
                            .foregroundColor(.ewGray900)
                        
                    }
                }
                
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isShowingProfileDetailView.toggle()

                    } label: {
                        Label<Text, EWAvatarImage>(title: {Text("Gakue")}) {
                            EWAvatarImage(image: UIImage(named: "demo-person-4")!)
                        }
                        
                    }
                }
                

            }
            .navigationTitle("Squad")
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $isShowingSettingsView) {
                SettingsView()
            }
            .fullScreenCover(isPresented: $isShowingProfileDetailView) {
                StatsBarsView(profilevm: profilevm)
            }
            .onAppear {
                Task{
                    await profilevm.fetchCurrentUser()
                }
            }
            
        
        //        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct PanelView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
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


