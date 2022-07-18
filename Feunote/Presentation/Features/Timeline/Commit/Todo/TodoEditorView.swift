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
        VStack(alignment:.leading, spacing: .ewPaddingVerticalLarge) {
            
            EWNavigationBar(title: "Todo", iconLeftImage: Image("delete"), iconRightImage: Image("check"), actionLeft: {
                commitvm.commit = FeuCommit()
                presentationMode.wrappedValue.dismiss()
                }, actionRight: {
                    Task{
                        commitvm.commit.commitType = .todo
                        await commitvm.saveCommit()
                        presentationMode.wrappedValue.dismiss()
                    }
                })
                
            EWCardTodoEditor(content: $commitvm.commit.titleOrName, description: $commitvm.commit.description, start: $commitvm.commit.todoStart, end: $commitvm.commit.todoEnd)

            }
        .padding()
        .alert(isPresented: $commitvm.hasError) {
            
            Alert(title: Text("Message"), message: Text(commitvm.appError?.errorDescription ?? "default error"), dismissButton: .destructive(Text("Ok")))
        }
            
    }
}

// MARK: - PREVIEW

struct TodoEditorView_Previews: PreviewProvider {
    

    static var previews: some View {
        TodoEditorView(commitvm: CommitViewModel(saveCommitUseCase: SaveCommitUseCase(), deleteCommitUseCase: DeleteCommitUseCase(), getAllCommitsUseCase: GetAllCommitsUseCase(), viewDataMapper: ViewDataMapper()))
            .preferredColorScheme(.light)
            .previewDevice("iPhone 13 Pro")
            .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}


