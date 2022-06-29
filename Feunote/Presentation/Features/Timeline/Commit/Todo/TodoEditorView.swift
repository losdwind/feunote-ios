//
//  Created by Robert Petras
//  SwiftUI Masterclass ♥ Better Apps. Less Code.
//  https://swiftuimasterclass.com 
//

import SwiftUI

struct TodoEditorView: View {
    // MARK: - PROPERTY
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    @ObservedObject var commitvm:CommitViewModel
    
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var isShowingWoopDetail:Bool = false
    
    
    // MARK: - FUNCTION
    
    
    
    // MARK: - BODY
    
    var body: some View {
        VStack {
            
            Spacer(minLength: .ewPaddingVerticalLarge)
                .onTapGesture{
                presentationMode.wrappedValue.dismiss()
                }

                
            EWNavigationBar(title: "Todo", iconLeftImage: Image("delete"), iconRightImage: Image("check"), actionLeft: {
                    
                }, actionRight: {
                    Task{
                        commitvm.commit.commitType = .todo
                        await commitvm.saveCommit()
                    }
                })
                
            EWCardTodoEditor(content: $commitvm.commit.titleOrName, description: $commitvm.commit.description, start: $commitvm.commit.todoStart, end: $commitvm.commit.todoEnd)

            }
        .padding()
            
    }
}

// MARK: - PREVIEW

struct TodoEditorView_Previews: PreviewProvider {
    

    static var previews: some View {
        TodoEditorView(commitvm: CommitViewModel(saveCommitUseCase: SaveCommitUseCase(), deleteCommitUseCase: DeleteCommitUseCase(), getAllCommitsUseCase: GetAllCommitsUseCase()))
            .preferredColorScheme(.light)
            .previewDevice("iPhone 13 Pro")
            .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}


