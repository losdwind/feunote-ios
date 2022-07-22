//
//  LocationPickerView.swift
//  Beliski
//
//  Created by Losd wind on 2021/12/5.
//

import SwiftUI

struct LocationPickerView: View {
    
    @EnvironmentObject var communityvm:CommunityViewModel
    @State private var searchText = ""
    @Environment(\.presentationMode) var presentationMode
    @State var cityList:[WorldCityJsonReader.CityList] = []
    
    var body: some View {
            List{
                ForEach(cityList) { cityList in
                            Section(header: Text(cityList.k)) {
                                ForEach(cityList.n) { city in
                                    Button {
                                        communityvm.selectedLocation = city
                                        
                                        presentationMode.wrappedValue.dismiss()
                                    } label: {
                                        HStack{
                                            Text("\(city.m)  \(city.x.uppercased())")
                                        }
                                        .foregroundColor(.accentColor)
                                    }


                                }
                            }
                        }
                    }

//            .toolbar {
//                ToolbarItem{
//                    Button {
//                        presentationMode.wrappedValue.dismiss()
//                    } label: {
//                        Image(systemName: "xmark")
//                            .foregroundColor(.gray)
//                    }
//
//                }
//            }
        
        
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onChange(of: searchText) { searchText in
         
            if !searchText.isEmpty {
                self.cityList = communityvm.worldCity.cityList.filter{
                    $0.n.contains(where: {$0.m.contains(searchText)})
                }
                
            } else {
                self.cityList = communityvm.worldCity.cityList
            }
        }
        .onAppear {
            self.cityList = communityvm.worldCity.cityList
        }
    }
}


struct LocationPickerView_Previews: PreviewProvider {
    static var previews: some View {
        LocationPickerView()
    }
}
