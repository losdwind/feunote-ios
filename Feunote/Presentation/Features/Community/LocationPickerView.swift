//
//  LocationPickerView.swift
//  Beliski
//
//  Created by Losd wind on 2021/12/5.
//

import SwiftUI




struct LocationPickerView: View {

    var worldCity = WorldCityJsonReader.shared.worldCity
    var chinaCity = ChinaCityJsonReader.shared.chinaCity

    @Binding var selectedLocation:WorldCityJsonReader.N?
    
    @State private var searchText = ""
    @Environment(\.presentationMode) var presentationMode
    @State var cityList:[WorldCityJsonReader.CityList] = []

    var body: some View {
            List{
                ForEach(cityList) { cityList in
                            Section(header: Text(cityList.k)) {
                                ForEach(cityList.n) { city in
                                    Button {
                                        self.selectedLocation = city
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
        
        
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onChange(of: searchText) { searchText in
         
            if !searchText.isEmpty {
                self.cityList = worldCity.cityList.filter{
                    $0.n.contains(where: {$0.m.contains(searchText)})
                }
                
            } else {
                self.cityList = worldCity.cityList
            }
        }
        .onAppear {
            self.cityList = worldCity.cityList
        }
    }
}


struct LocationPickerView_Previews: PreviewProvider {
    @State static var selectedLocation:WorldCityJsonReader.N?
    static var previews: some View {
        LocationPickerView(selectedLocation: $selectedLocation, cityList: [])
    }
}
