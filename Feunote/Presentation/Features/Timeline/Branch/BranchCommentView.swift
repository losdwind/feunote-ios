//
//  BranchCommentView.swift
//  Feunote
//
//  Created by Losd wind on 2022/8/10.
//

import SwiftUI
extension BranchCommentsView {
    @MainActor
    class ViewModel: ObservableObject {
        init(branch: AmplifyBranch, getCommentsUseCase: GetCommentsUseCaseProtocol, saveCommentUseCase: SaveCommentUseCaseProtocol, deleteCommentUseCase: DeleteCommentUseCaseProtocol) {
            self.branch = branch
            self.getCommentsUseCase = getCommentsUseCase
            self.saveCommentUseCase = saveCommentUseCase
            self.deleteCommentUseCase = deleteCommentUseCase
        }

        private var getCommentsUseCase: GetCommentsUseCaseProtocol
        private var saveCommentUseCase: SaveCommentUseCaseProtocol
        private var deleteCommentUseCase: DeleteCommentUseCaseProtocol

        @Published var branch: AmplifyBranch
        @Published var fetchedComments: [AmplifyComment] = []

        @Published var hasError = false
        @Published var appError: Error?

        func getComments() async {
                do {
                    self.fetchedComments = try await getCommentsUseCase.execute(branchID: branch.id)
                } catch {
                    hasError = true
                    appError = error as? Error
                }
        }

        func sendComment(content: String) {
            Task {
                do {
                    try await saveCommentUseCase.execute(branchID: branch.id, content: content)
                    await getComments()
                } catch {
                    hasError = true
                    appError = error as? Error
                }
            }
        }
    }
}

struct BranchCommentsView: View {
    @StateObject var viewModel: ViewModel

    init(branch: AmplifyBranch, getCommentsUseCase: GetCommentsUseCaseProtocol = GetCommentsUseCase(), saveCommentUseCase: SaveCommentUseCaseProtocol = SaveCommentUseCase(), deleteCommentUseCase: DeleteCommentUseCaseProtocol = DeleteCommentUseCase()) {
        _viewModel = StateObject(wrappedValue: ViewModel(branch: branch, getCommentsUseCase: getCommentsUseCase, saveCommentUseCase: saveCommentUseCase, deleteCommentUseCase: deleteCommentUseCase))
    }

    @State var content: String = ""

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
                    ForEach(viewModel.fetchedComments, id: \.id) { comment in
                        HStack(alignment: .top, spacing: .ewPaddingHorizontalDefault) {
                            PersonAvatarView(imageKey: comment.creator.avatarKey)

                            VStack(alignment: .leading, spacing: .ewPaddingVerticalDefault) {
                                Text(comment.creator.nickName ?? "Invalid Name")
                                    .font(.ewHeadline)
                                    .foregroundColor(.ewBlack)

                                Text(comment.content ?? "Invalid Comment")
                                    .foregroundColor(.ewBlack)
                                    .font(.ewBody)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
            }
            .frame(maxHeight:320, alignment: .top)

            .task {
                await viewModel.getComments()
            }

            HStack(alignment: .center, spacing: .ewPaddingHorizontalDefault) {
                EWTextField(input: $content, icon: nil, placeholder: "comment")

                EWButton(text: "Send", style: .primarySmall) {
                    viewModel.sendComment(content: content)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 80, alignment: .bottom)
        }
        .padding()
    }
}

struct BranchCommentView_Previews: PreviewProvider {
    static var previews: some View {
        BranchCommentsView(branch: AmplifyBranch(privacyType: .open, title: "", description: ""))
    }
}
