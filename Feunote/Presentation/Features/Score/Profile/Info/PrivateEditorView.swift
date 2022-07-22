//
//  ProfileEditorView.swift
//  Beliski
//
//  Created by Losd wind on 2021/10/29.
//

import SwiftUI
import MapKit

struct PrivateEditorView: View {
    
    @ObservedObject var profilevm:ProfileViewModel

    
    @State var birthday:Date = Date(timeIntervalSince1970: 0)
    @State var address:String = ""
    @State var jobCategory:String = "Architecture and engineering"
    @State var socialMediaCategory:SocialMediaCategory = .linkedin

    var body: some View {
        Form{
            Section{
                Group{
                    
                   // fullname
                HStack{
                    Text("Full Name")
                    TextField("Full Name", text: $profilevm.user.realName ?? "N.A", prompt: Text("e.g. Adam Smith"))
                }
                    
                    
                // gender
                HStack{
                    Text("Gender")
                    Picker("Gender", selection: $profilevm.user.gender ?? "NA") {
                        Text("Male").tag("Male")
                        Text("Female").tag("Female")
                        Text("Misc.").tag("Misc.")
                    }
                    .pickerStyle(.segmented)
                }
                
                    DatePicker("Birthday", selection: $birthday)
                
                
                    // address
                HStack{
                    Text("Address")
                    TextField("Address", text: $profilevm.user.address ?? "N.A", prompt: Text("Hechuan, Chongqing, CHINA "))
                }
                    
                    
                // mobile
                HStack{
                    Text("Mobile")
                    TextField("mobile", text: $profilevm.user.phone ?? "NA", prompt: Text("000-000-0000"))
                }
                
                
                // job
                HStack{
                    Text("Job")
                    Picker("Category", selection: $jobCategory) {
                        ForEach(Array(JOBS.keys), id:\.self) { key in
                            Text(key).tag(key)
                                .frame(width: 60)
                        }
                    }
                    .pickerStyle(.menu)
                    

                    Picker("Job", selection:$profilevm.user.job){
                        ForEach(JOBS[jobCategory]!, id:\.self) { job in
                            Text(job).tag(job)
                                .frame(width: 60)
                        }
                                
                    }
                    .pickerStyle(.menu)
                                        

                }
                    
                    // income
                   
                    
                    HStack {
                        Text("Annual Income")
                        TextField("Annual Income", text: $profilevm.user.income ?? "N.A", prompt: Text("$"))
                        
                    

                        
                    }

                    // marital status

                    HStack{
                        Text("Marital Status")

                        Picker("Marital Status", selection: $profilevm.user.marriage) {
                            ForEach(Marriage.allCases, id:\.self){m in
                                Text(m.rawValue).tag(m)
                            }
                        }
                        .pickerStyle(.menu)

                    }
                
                }
                
            } header: {
                Text("Basic Infos")
            }
            
                
                Section{
                    Group{
                        ForEach(SocialMediaCategory.allCases, id:\.self){ category in
                            HStack {
                                Label {
                                    Text(category.rawValue)
                                        .font(.headline)
                                } icon: {
                                    Image(category.rawValue)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20, alignment: .center)
                                        .tag(category)
                                }

                                
                                Spacer()
                                Button {
                                    profilevm.connectSocialMedia(source: socialMediaCategory, completion: {_ in})
                                } label: {
                                    Text("Connect")
                                        .font(.footnote)
                                        .foregroundColor(.blue)
                                       
                                }
                                .buttonStyle(.bordered)
                                .buttonBorderShape(.capsule)

                                
                            }

                            
                            
                        }
                 
                    
                    

                    }
                    
                } header: {
                    Text("Social Media")
                }
            
            
            Section {
                // interedt
                HStack {
                    Text("Pending to add")
                    

                    
                }
            } header: {
                Text("Personal Interest")
            }

            }

        }
    }


struct ProfileEditorView_Previews: PreviewProvider {
    static var previews: some View {
        PrivateEditorView(profilevm: ProfileViewModel(saveProfileUserCase: SaveProfileUseCase(), getProfileByIDUserCase: GetProfileByIDUseCase(), getCurrentProfileUseCase: GetCurrentProfileUseCase(), deleteProfileUseCase: DeleteProfileUseCase(), viewDataMapper: ViewDataMapper()))

    }
}
