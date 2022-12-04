//
//  TimelineView.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/15.
//

import Amplify
import Combine
import SwiftUI

enum TimelineTab: String, CaseIterable {
    case All
    case MOMENTS
    case EVENTS
    case PERSONS
    case BRANCHES
}

class TimelineViewModel: ObservableObject {
    private var getOwnedCommitsUseCase: GetCommitsUseCaseProtocol = GetOwnedCommitsUseCase()
    private var getOwnedBranchesUseCase: GetBranchesUseCaseProtocol = GetOwnedBranchesUseCase()

    private var subscribeOwnedCommitsUseCase: SubscribeCommitsUseCaseProtocol = SubscribeOwnedCommitsUseCase()
    private var subscribeOwnedBranchesUseCase: SubscribeBranchesUseCaseProtocol = SubscribeOwnedBranchesUseCase()
    private var getParticipatedBranchesUseCase: GetParticipatedBranchesUseCaseProtocol = GetParticipatedBranchesUseCase()

    @Published var selectedMainTab: BottomTab = .timeline
    @Published var selectedTab: TimelineTab = .All
    @Published var searchInput: String = ""

    @Published var fetchedOwnedCommits: [AmplifyCommit] = []
    @Published var fetchedOwnedBranches: [AmplifyBranch] = []
    @Published var fetchedParticipatedBranches: [AmplifyBranch] = []

    @Published var hasError = false
    @Published var appError: Error?

    private var dataStoreCommitPublisher: AnyCancellable?
    private var dataStoreBranchPublisher: AnyCancellable?
    private var subscribers = Set<AnyCancellable>()

    @Published var isCommitSynced = true
    @Published var isBranchSynced = true

    @Published private(set) var user: AmplifyUser?

//    init() {
//        AppRepoManager.shared.dataStoreRepo.eventsPublisher
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: onReceiveCompletion(completion:),
//                  receiveValue: onReceive(event:))
//            .store(in: &subscribers)
//        AppRepoManager.shared.errorTopic
//            .receive(on: DispatchQueue.main)
//            .sink { error in
//                self.appError = error
//                self.hasError = true
//            }
//            .store(in: &subscribers)
//        subscribeAllCommits(page: 0)
//        subscribeAllBranchs(page: 0)

//        print("initalized timeline viewmodel")
//    }

    func getAllCommits(page: Int) async {
        do {
            let commits = try await getOwnedCommitsUseCase.execute(page: page)

            print("fetched commits: \(fetchedOwnedCommits.count)")
            DispatchQueue.main.async {
                if page != 0 {
                    self.fetchedOwnedCommits.append(contentsOf: commits)
                } else {
                    self.fetchedOwnedCommits = commits
                }
            }
        } catch {
            hasError = true
            appError = error as? Error
        }
    }

    func getAllBranchs(page: Int) async {
        do {
            let branches = try await getOwnedBranchesUseCase.execute(page: page)
            print("fetched branches: \(fetchedOwnedBranches.count)")
            DispatchQueue.main.async {
                if page != 0 {
                    self.fetchedOwnedBranches.append(contentsOf: branches)
                } else {
                    self.fetchedOwnedBranches = branches
                }
            }

        } catch {
            hasError = true
            appError = error as? Error
        }
    }

    func subscribeAllCommits(page: Int) {
        subscribeOwnedCommitsUseCase.execute(page: page).sink {
            if case .failure(let error) = $0 {
                print("Got failed event with error \(error)")
                self.hasError = true
                self.appError = error as? Error
            }
        } receiveValue: {
            querySnapshot in
            print("fetched commits: \(querySnapshot.items.count), isSynced: \(querySnapshot.isSynced)")
            DispatchQueue.main.async {
                self.fetchedOwnedCommits = querySnapshot.items
            }
        }
        .store(in: &subscribers)
    }




    func subscribeAllBranchs(page: Int) {
        subscribeOwnedBranchesUseCase.execute(page: page).sink {
            if case .failure(let error) = $0 {
                print("Got failed event with error \(error)")
                self.hasError = true
                self.appError = error as? Error
            }
        } receiveValue: {
            querySnapshot in
            print("fetched branches: \(querySnapshot.items.count), isSynced: \(querySnapshot.isSynced)")
            DispatchQueue.main.async {
                self.fetchedOwnedBranches = querySnapshot.items
            }
        }
        .store(in: &subscribers)
    }

    func getParticipatedBranches() async {
        do {
            guard let userID = AppRepoManager.shared.authRepo.authUser?.userId else { return }
            let branches = try await getParticipatedBranchesUseCase.execute(userID: userID)
            DispatchQueue.main.async {
                for branch in branches {
                    if !self.fetchedOwnedBranches.contains(where: {$0.id == branch.id}){
                        self.fetchedOwnedBranches.insert(branch, at: 0)
                    }
                }
                self.fetchedParticipatedBranches = branches
                print("get participated branches: \(branches.count)")
            }

        } catch {
            hasError = true
            appError = error as? Error
        }
    }


    func getLemmatizedArray() -> Array<String>{
        var strings:String = ""
        for item in self.fetchedOwnedCommits {
            strings += " \(item.titleOrName ?? "") \(item.description ?? "")".lemmatized()
        }
        return strings.components(separatedBy: " ")
    }



    func getWordFrequencyDict() -> Dictionary<String, Int>{
        let lemmaArray = getLemmatizedArray()
        let mappedItems = lemmaArray.map{($0, 1)}
        let lemmaDict = Dictionary(mappedItems, uniquingKeysWith: +)
        print(lemmaDict)
        return lemmaDict
    }


    func getWordElements(forSwiftUI:Bool = true) -> [WordElement]{
        return getWordFrequencyDict().map{WordElement(text: $0.key, color:UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), fontName: "PT Sans", fontSize: forSwiftUI ? CGFloat($0.value) * 20 : CGFloat($0.value) * 10)}

    }


    private func onReceiveCompletion(completion: Subscribers.Completion<DataStoreError>) {
        if case .failure(let error) = completion {
            DispatchQueue.main.async {
                self.appError = error
                self.hasError = true
            }
        }
    }

    private func onReceive(event: DataStoreServiceEvent) {
        switch event {
            case .userSynced:
                DispatchQueue.main.async {
                    self.user = AppRepoManager.shared.dataStoreRepo.amplifyUser
                }
//                tryLoadCommitsAndBranches()
            case .commitSynced:
                print("get commit synced message")
                dataStoreCommitPublisher?.cancel()
                Task { await getAllCommits(page: 0) }
                isCommitSynced = true
            case .branchSynced:
                print("get branch synced message")
                dataStoreBranchPublisher?.cancel()

                Task { await getAllBranchs(page: 0) }
                isBranchSynced = true
            case .commitCreated(let newCommit):
                DispatchQueue.main.async {
                    self.createCommit(newCommit)
                }
//                getNumberOfMyPosts()
            case .commitDeleted(let commitID):
                removeCommit(commitID)
//                getNumberOfMyPosts()
            case .branchCreated(let newBranch):
                DispatchQueue.main.async {
                    self.createBranch(newBranch)
                }
//                            getNumberOfMyPosts()
            case .branchDeleted(let branchID):
                removeBranch(branchID)
//                            getNumberOfMyPosts()
            default:
                break
        }
    }

    private func createCommit(_ newCommit: AmplifyCommit) {
        DispatchQueue.main.async {
            for index in 0 ..< self.fetchedOwnedCommits.count {
                guard self.fetchedOwnedCommits[index].id == newCommit.id else {
                    continue
                }
                self.fetchedOwnedCommits[index] = newCommit
                return
            }
            self.fetchedOwnedCommits.insert(newCommit, at: 0)
        }
    }

    private func createBranch(_ newBranch: AmplifyBranch) {
        DispatchQueue.main.async {
            for index in 0 ..< self.fetchedOwnedBranches.count {
                guard self.fetchedOwnedBranches[index].id == newBranch.id else {
                    continue
                }
                self.fetchedOwnedBranches[index] = newBranch
                return
            }
            self.fetchedOwnedBranches.insert(newBranch, at: 0)
        }
    }

    private func removeCommit(_ commitID: String) {
        DispatchQueue.main.async {
            for index in 0 ..< self.fetchedOwnedCommits.count {
                guard self.fetchedOwnedCommits[index].id == commitID else {
                    continue
                }
                self.fetchedOwnedCommits.remove(at: index)
                break
            }
        }
    }

    private func removeBranch(_ branchID: String) {
        DispatchQueue.main.async {
            for index in 0 ..< self.fetchedOwnedBranches.count {
                guard self.fetchedOwnedBranches[index].id == branchID else {
                    continue
                }
                self.fetchedOwnedBranches.remove(at: index)
                break
            }
        }
    }

    /// This is called when `dataStoreService` has notified us that the User has been synced.
    /// When App launches, a user performs a sign in:
    ///     The local DB is empty, the first `fetchMyPosts` returns nothing.
    ///     But since the `InitialSync` is kicked off, `dataStorePublishser` keeps receiving `Post` Model,
    ///     a `fetchMyPosts` is triggered either every 10 posts or every 3 seconds which returns posts
    /// When App launches, there is an user signed in:
    ///     The local DB is not empty, the first `fetchMyPosts` returns 10 posts,
    ///     and:
    ///     If `SyncEngine` is doing a `Full Sync`:
    ///         `dataStorePublishser` receives incoming `Post` Model from cloud,
    ///         a `fetchMyPosts` is triggered either every 10 posts or every 3 seconds which returns posts
    ///     if `SyncEngine` is doing a `Delta Sync`:
    ///         the `dataStorePublishser` is not triggered
    /// Finally, `dataStorePublishser` is cancelled when `dataStoreService` notifies us that Post has been synced
    ///
    ///
    ///
    /*
     private func tryLoadCommitsAndBranches() {
         guard user != nil else {
             return
         }
             getAllCommits(page: 0)
             getAllBranchs(page: 0)

         dataStoreCommitPublisher = AppRepoManager.shared.dataStoreRepo.dataStorePublisher(for: AmplifyCommit.self)
             .receive(on: DispatchQueue.main)
             .collect(.byTimeOrCount(DispatchQueue.main, 3.0, 10))
             .sink {
                 if case .failure(let error) = $0 {
                     Amplify.log.error("Subscription received error - \(error.localizedDescription)")
                 }
             }
     receiveValue: { [weak self] _ in
             await self?.getAllCommits(page: 0)
             }

         dataStoreBranchPublisher = AppRepoManager.shared.dataStoreRepo.dataStorePublisher(for: AmplifyBranch.self)
             .receive(on: DispatchQueue.main)
             .collect(.byTimeOrCount(DispatchQueue.main, 3.0, 10))
             .sink {
                 if case .failure(let error) = $0 {
                     Amplify.log.error("Subscription received error - \(error.localizedDescription)")
                 }
             }
     receiveValue: { [weak self] _ in
                 self?.getAllBranchs(page: 0)
             }
     }

     deinit {
         self.fetchedOwnedCommits.removeAll()
         self.fetchedOwnedBranches.removeAll()
         self.user = nil
     }
      */
}

struct TimelineView: View {
    @EnvironmentObject var timelinevm: TimelineViewModel

    var body: some View {
        // TabView
        TabView(selection: $timelinevm.selectedTab) {
            CommitListView(fetchedCommits: $timelinevm.fetchedOwnedCommits).tag(TimelineTab.All)

            CommitListView(fetchedCommits: Binding(get: {
                timelinevm.fetchedOwnedCommits.filter { $0.commitType == .moment }
            }, set: { new in
                timelinevm.fetchedOwnedCommits = new
            })).tag(TimelineTab.MOMENTS)

            CommitListView(fetchedCommits: Binding(get: {
                timelinevm.fetchedOwnedCommits.filter { $0.commitType == .todo }
            }, set: { new in
                timelinevm.fetchedOwnedCommits = new
            })).tag(TimelineTab.EVENTS)

            CommitListView(fetchedCommits: Binding(get: {
                timelinevm.fetchedOwnedCommits.filter { $0.commitType == .person }
            }, set: { new in
                timelinevm.fetchedOwnedCommits = new
            }))
            .tag(TimelineTab.PERSONS)

            BranchListView(branches: $timelinevm.fetchedOwnedBranches)
                .tag(TimelineTab.BRANCHES)
                .task {
                    await timelinevm.getParticipatedBranches()

                }
        }

        .padding()
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(maxWidth: 640)
//        .task {
//            await timelinevm.getAllCommits(page: 0)
//        }


//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                EWSelector(option: $timelinevm.selectedTab)
//            }
//
//            ToolbarItem(placement: .navigationBarTrailing) {
//                NavigationLink {
//                    SearchView(input: $timelinevm.searchInput)
//                } label: {
//                    Image("search")
//                }
//            }
//
//            ToolbarItem(placement: .navigationBarTrailing) {
//                NavigationLink {
//                    InspireView()
//                } label: {
//                    Image("analytics")
//                }
//            }
//        }
    }
}

struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
    }
}
