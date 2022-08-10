//
//  BranchCommentView.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/10.
//

import SwiftUI
extension BranchCommentsView {
    class ViewModel:ObservableObject {
        init(branch:AmplifyBranch, getCommentsUseCase:GetCommentsUseCaseProtocol, saveActionUseCase: SaveActionUseCaseProtocol, deleteActionUseCase: DeleteActionUseCaseProtocol) {
            self.branch = branch
            self.getCommentsUseCase = getCommentsUseCase
            self.saveActionUseCase = saveActionUseCase
            self.deleteActionUseCase = deleteActionUseCase
        }

        private var getCommentsUseCase:GetCommentsUseCaseProtocol
        private var saveActionUseCase:SaveActionUseCaseProtocol
        private var deleteActionUseCase:DeleteActionUseCaseProtocol

        @Published var branch:AmplifyBranch
        @Published var fetchedComments:[AmplifyAction] = []

        @Published var hasError = false
        @Published var appError:AppError?


        func getComments() {
            Task {
                do {
                    self.fetchedComments = try await getCommentsUseCase.execute(branchID: branch.id)
                } catch(let error){
                    hasError = true
                    appError = error as? AppError
                }
            }
        }

        func sendComment(content:String)  {
            Task {
                do {
                    try await saveActionUseCase.execute(branchID:branch.id, actionType:.comment, content:content)
                }catch(let error) {
                    hasError = true
                    appError = error as? AppError
                }
            }
        }

    }
}
struct BranchCommentsView: View {
    @StateObject var viewModel:ViewModel

    init(branch:AmplifyBranch, getCommentsUseCase:GetCommentsUseCaseProtocol = GetCommentsUseCase(), saveActionUseCase: SaveActionUseCaseProtocol = SaveActionUseCase(), deleteActionUseCase: DeleteActionUseCaseProtocol = DeleteActionUseCase()){
        self._viewModel = StateObject(wrappedValue: ViewModel(branch: branch, getCommentsUseCase: getCommentsUseCase, saveActionUseCase: saveActionUseCase, deleteActionUseCase: deleteActionUseCase))
    }

    @State var content:String = ""

    var body: some View {
        ZStack{
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
                    ForEach(viewModel.fetchedComments, id:\.id){ comment in
                        HStack(alignment: .top, spacing: .ewPaddingHorizontalDefault){

                            PersonAvatarView(imageKey: comment.creator.avatarKey)

                            VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault){

                                Text(comment.creator.nickName ?? "Invalid Name")
                                    .font(.ewHeadline)
                                    .foregroundColor(.ewBlack)

                                Text(comment.content ?? "Invalid Comment")
                                    .foregroundColor(.ewBlack)
                                    .font(.ewBody)
                            }
                            .frame(maxWidth:.infinity, alignment: .leading)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.getComments()
            }

            HStack(alignment: .center, spacing: .ewPaddingHorizontalDefault) {
                EWTextField(input: $content , icon: nil, placeholder: "comment")

                EWButton(text: "Send", style: .primarySmall) {
                    viewModel.sendComment(content: content)
                }

            }
                .frame(maxWidth:.infinity, maxHeight: 80, alignment: .bottom)

        }
        .padding()
    }

}

struct BranchCommentView_Previews: PreviewProvider {
    static var previews: some View {
        BranchCommentsView(branch: AmplifyBranch(privacyType: .open, title: "", description: ""))
    }
}
