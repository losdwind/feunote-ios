//
//  Created by Robert Petras
//  SwiftUI Masterclass ♥ Better Apps. Less Code.
//  https://swiftuimasterclass.com 
//

import SwiftUI

struct TodoEditorView: View {
    // MARK: - PROPERTY
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    @ObservedObject var todovm:TodoViewModel
    
    
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
                        await todovm.saveTodo()
                    }
                })
                
            EWCardTodoEditor(content: $todovm.todo.content, description: $todovm.todo.description, start: $todovm.start, end: $todovm.end)

            }
        .padding()
            
    }
}

// MARK: - PREVIEW

struct TodoEditorView_Previews: PreviewProvider {
    

    static var previews: some View {
        TodoEditorView(todovm: TodoViewModel(saveTodoUseCase: SaveTodoUseCase(), deleteTodoUseCase: DeleteTodoUseCase(), getAllTodosUseCase: GetAllTodosUseCase()))
            .preferredColorScheme(.light)
            .previewDevice("iPhone 13 Pro")
            .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}


