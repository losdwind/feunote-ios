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
            HStack{
                
                Button {
                    
                    withAnimation{
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Button {
                    
                    withAnimation{
                        isShowingWoopDetail.toggle()
                    }
                    
                } label: {
                    Image(systemName: "info.circle")
                        .font(.title2)
                        .foregroundColor(.black)
                }
            }
            .overlay(
                
                Text("New WOOP Task")
                    .font(.system(size: 18))
            )
            
            Spacer()
            
            VStack(spacing: 16) {
                
                if todovm.todo.isUsingWoop {
                    VStack(alignment:.leading, spacing: 20) {
                        
                        Group {
                    Text("A meaningful, challenging, and feasible wish or goal:")
                    
                    TextField("Add wish", text: $todovm.todo.wish, prompt: Text("Wish"))
                        .textFieldStyle(TodoTextFieldStyle(isDarkMode: isDarkMode))
                        }
                        
                        Group {
                    Text("The best result or feeling from accomplishing your wish:")
                    
                    TextField("Outcome", text:$todovm.todo.outcome , prompt: Text("Outcome"))
                        .textFieldStyle(TodoTextFieldStyle(isDarkMode: isDarkMode))
                    
                        }
                        
                        Group {
                    Text("Something prevents you from accomplishing your wish:")
                    
                    TextField("Obstacle", text:$todovm.todo.obstacle , prompt: Text("Obstacle"))
                        .textFieldStyle(TodoTextFieldStyle(isDarkMode: isDarkMode))
                        }
                        Group {
                    Text("If occuring the obstacle, what will you do:")
                    
                    TextField("Plan", text:$todovm.todo.plan , prompt: Text("Plan"))
                        .textFieldStyle(TodoTextFieldStyle(isDarkMode: isDarkMode))
                    
                        }
                    }
                } else {
                    
                    TextField("Add Todo", text: $todovm.todo.content, prompt: Text("What do you plan to do"))
                        .textFieldStyle(TodoTextFieldStyle(isDarkMode: isDarkMode))
                    
                }
                
               
                

                

                    DatePicker(selection: $todovm.reminder, in: Date()...) {
                        
                        Image(systemName: "bell")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.pink)
                    }
                
                

                
                Button(action: {
                    
                    todovm.uploadTodo { success in
                        if success {
                            todovm.todo = Todo()
                            todovm.fetchTodos{_ in}
                        }
                    }
                    playSound(sound: "sound-ding", type: "mp3")
//                    feedback.notificationOccurred(.success)
                    presentationMode.wrappedValue.dismiss()
                    
                }, label: {
                    Spacer()
                    Text("SAVE")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .padding()
//                        .foregroundColor(todovm.todo.content.count == 0 ? Color.gray : Color.pink)
                    Spacer()
                })
                    .modifier(SaveButtonBackground(isButtonDisabled: (todovm.todo.content.count == 0 && todovm.todo.wish.count == 0)))
            } //: VSTACK
//            .padding(.horizontal)
//            .padding(.vertical, 20)
//            .background(
//                isDarkMode ? Color(UIColor.secondarySystemBackground) : Color.white
//            )
//            .cornerRadius(16)
//            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
//            .frame(maxWidth: 640)
        }//: VSTACK
        .padding()
        .fullScreenCover(isPresented: $isShowingWoopDetail) {
                WoopDetailView()
        }
            
    }
}

// MARK: - PREVIEW

struct TodoEditorView_Previews: PreviewProvider {
    

    static var previews: some View {
        TodoEditorView(todovm: TodoViewModel())
            .preferredColorScheme(.light)
            .previewDevice("iPhone 13 Pro")
            .background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}


