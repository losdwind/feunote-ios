//
//  NewGridView.swift
//  Beliski
//
//  Created by Losd wind on 2021/11/19.
//

import SwiftUI
struct NewGridView: View {
    
    @EnvironmentObject var commitvm:CommitViewModel
    @EnvironmentObject var branchvm:BranchViewModel
    
    @State var isShowingMomentEditor = false
    @State var isShowingTodoEditor = false
    @State var isShowingPersonEditor = false
    @State var isShowingBranchEditor = false
    @State var isShowingAlert = false

    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    
    
    var body: some View {
        VStack(spacing:20) {
            HStack {
                // New Moment
                Button(action: {
                    isShowingMomentEditor = true
                    playSound(sound: "sound-ding", type: "mp3")
                    commitvm.commit.commitType = .moment
                }, label: {
                    NewButton(systemImageName: "note.text", buttonName: "Moment")
                })
                    .sheet(isPresented: $isShowingMomentEditor){
                        MomentEditorView()}
                
                
                // MARK: - here we have a bug
                
                // New  Todo
                Button(action: {
                    isShowingTodoEditor = true
                    playSound(sound: "sound-ding", type: "mp3")
                    commitvm.commit.commitType = .todo

                }, label: {
                    NewButton(systemImageName: "checkmark", buttonName: "Todo")
                    
                })

                    .sheet(isPresented: $isShowingTodoEditor) {
                        TodoEditorView()
                    }
            }
            
            
            HStack{
                // New Person
                Button(action: {
                    isShowingPersonEditor = true
                    playSound(sound: "sound-ding", type: "mp3")
                    commitvm.commit.commitType = .person

                }, label: {

                    
                    NewButton(systemImageName: "person.fill", buttonName: "Person")
                    
                })
                    .sheet(isPresented: $isShowingPersonEditor){
                        PersonEditorView()}
                
                // New Branch
                Button(action: {
                    isShowingBranchEditor = true
                    playSound(sound: "sound-ding", type: "mp3")
                }, label: {
                    NewButton(systemImageName: "arrow.triangle.branch", buttonName: "Branch")
                    
                })
                    .sheet(isPresented: $isShowingBranchEditor) {
                        BranchCardEditorView()
                        
                    }
                
            }
            
        }
    }
}

struct NewGridView_Previews: PreviewProvider {
    static var previews: some View {
        NewGridView()
    }
}

struct NewButton: View {
    var systemImageName:String
    var buttonName:String
    var body: some View {
        VStack{
            Image(systemName: systemImageName)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .frame(width:40, height:40)
            Text(buttonName)
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .frame(width: 120, alignment: .center)
        }
        .padding()
        .foregroundColor(Color.pink)
        .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10))
    }
}
