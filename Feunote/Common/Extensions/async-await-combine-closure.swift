//
//  async-await-combine-closure.swift
//  Feunote
//
//  Created by Losd wind on 2022/6/28.
//

import _Concurrency
import Combine
import Dispatch
import Foundation

// MARK: General
struct SomeError: Error {}

extension AnyPublisher {

    init(builder: @escaping (AnySubscriber<Output, Failure>) -> Cancellable?) {
        self.init(
            Deferred<Publishers.HandleEvents<PassthroughSubject<Output, Failure>>> {
                let subject = PassthroughSubject<Output, Failure>()
                var cancellable: Cancellable?
                cancellable = builder(AnySubscriber(subject))
                return subject
                    .handleEvents(
                        receiveCancel: {
                            cancellable?.cancel()
                            cancellable = nil
                        }
                    )
            }
        )
    }

}

extension Task: Cancellable {}

// MARK: Original Methods
enum AsyncAwait {

    static func doSomething() async -> String {
        String()
    }

    static func doSomethingThrowing() async throws -> String {
        String()
    }

    static func doSomethingMore() -> AsyncStream<String> {
        AsyncStream { continuation in
            continuation.yield(String())
            continuation.yield(String())
            continuation.finish()
        }
    }

    static func doSomethingMoreThrowing() -> AsyncThrowingStream<String, Error> {
        AsyncThrowingStream { continuation in
            continuation.yield(String())
            continuation.finish(throwing: SomeError())
        }
    }

}

enum Combine {

    static func doSomething() -> AnyPublisher<String, Never> {
        Just(String()).eraseToAnyPublisher()
    }

    static func doSomethingThrowing() -> AnyPublisher<String, SomeError> {
        Just(String()).setFailureType(to: SomeError.self).eraseToAnyPublisher()
    }

    static func doSomethingMore() -> AnyPublisher<String, Never> {
        Just(String()).eraseToAnyPublisher()
    }

    static func doSomethingMoreThrowing() -> AnyPublisher<String, SomeError> {
        Just(String()).setFailureType(to: SomeError.self).eraseToAnyPublisher()
    }

}

enum Closures {

    static func doSomething(completion: @escaping (String) -> Void) {
        completion(String())
    }

    static func doSomethingThrowing(completion: @escaping (Result<String, SomeError>) -> Void) {
        completion(.success(String()))
    }

    static func doSomethingMore(update: @escaping (String) -> Void) {
        update(String())
        update(String())
    }

    static func doSomethingMoreThrowing(update: @escaping (Result<String, SomeError>) -> Void) {
        update(.success(String()))
        update(.failure(SomeError()))
    }

}

// MARK: Async/Await to Combine
enum AsyncAwaitToCombine {

    static func doSomething() -> AnyPublisher<String, Never> {
        AnyPublisher { subscriber in
            Task {
                let result = await AsyncAwait.doSomething()
                subscriber.receive(result)
                subscriber.receive(completion: .finished)
            }
        }
    }

    static func doSomethingThrowing() -> AnyPublisher<String, Error> {
        AnyPublisher { subscriber in
            Task {
                do {
                    let result = try await AsyncAwait.doSomethingThrowing()
                    subscriber.receive(result)
                    subscriber.receive(completion: .finished)
                } catch {
                    subscriber.receive(completion: .failure(error))
                }
            }
        }
    }

    static func doSomethingMore() -> AnyPublisher<String, Never> {
        AsyncAwait.doSomethingMore().publisher
    }

    static func doSomethingMoreThrowing() -> AnyPublisher<String, Error> {
        AsyncAwait.doSomethingMoreThrowing().publisher
    }

}

extension AsyncSequence {

    var publisher: AnyPublisher<Element, Error> {
        AnyPublisher { subscriber in
            Task {
                do {
                    for try await value in self {
                        subscriber.receive(value)
                    }
                    subscriber.receive(completion: .finished)
                } catch {
                    subscriber.receive(completion: .failure(error))
                }
            }
        }
    }

}

extension AsyncStream {

    var publisher: AnyPublisher<Element, Never> {
        AnyPublisher { subscriber in
            Task {
                for await value in self {
                    subscriber.receive(value)
                }
                subscriber.receive(completion: .finished)
            }
        }
    }

}

// MARK: Async/Await to Closures
enum AsyncAwaitToClosures {

    static func doSomething(completion: @escaping (String) -> Void) {
        Task {
            let result = await AsyncAwait.doSomething()
            completion(result)
        }
    }

    static func doSomethingThrowing(completion: @escaping (Result<String, Error>) -> Void) {
        Task {
            do {
                let result = try await AsyncAwait.doSomethingThrowing()
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
    }

    static func doSomethingMore(completion: @escaping (String) -> Void) {
        Task {
            for await value in AsyncAwait.doSomethingMore() {
                completion(value)
            }
        }
    }

    static func doSomethingMoreThrowing(completion: @escaping (Result<String, Error>) -> Void) {
        Task {
            do {
                for try await value in AsyncAwait.doSomethingMoreThrowing() {
                    completion(.success(value))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }

}

// MARK: Combine to Async/Await
enum CombineToAsyncAwait {

    static func doSomething() async -> String {
        await Combine.doSomething().values.first(where: { _ in true })!
    }

    static func doSomethingThrowing() async throws -> String {
        try await Combine.doSomethingThrowing().values.first(where: { _ in true })!
    }

    static func doSomethingMore() -> AsyncPublisher<AnyPublisher<String, Never>> {
        Combine.doSomethingMore().values
    }

    static func doSomethingMoreThrowing() -> AsyncThrowingPublisher<AnyPublisher<String, SomeError>> {
        Combine.doSomethingThrowing().values
    }

}

// MARK: Combine to Closures
enum CombineToClosures {

    static func doSomething(completion: @escaping (String) -> Void) {
        var cancellable: AnyCancellable?
        cancellable = Combine.doSomething()
            .sink { value in
                completion(value)
                _ = cancellable // this is simply to ignore Swift's warning `Variable 'cancellable' was written to, but never read`
                cancellable = nil
            }
    }

    static func doSomethingThrowing(completion: @escaping (Result<String, SomeError>) -> Void) {
        var cancellable: AnyCancellable?
        cancellable = Combine.doSomethingThrowing()
            .sink { subscriptionCompletion in
                switch subscriptionCompletion {
                case let .failure(error):
                    completion(.failure(error))
                case .finished:
                    break
                }
                _ = cancellable // this is simply to ignore Swift's warning `Variable 'cancellable' was written to, but never read`
                cancellable = nil
            } receiveValue: { value in
                completion(.success(value))
            }
    }

    static func doSomethingMore(completion: @escaping (String) -> Void) {
        var cancellable: AnyCancellable?
        cancellable = Combine.doSomethingMore()
            .sink { _ in // since the subscription's completion cannot contain an error, it can only be `.finished` and therefore is irrelevant here
                _ = cancellable // this is simply to ignore Swift's warning `Variable 'cancellable' was written to, but never read`
                cancellable = nil
            } receiveValue: { value in
                completion(value)
            }
    }


    static func doSomethingMoreThrowing(completion: @escaping (Result<String, SomeError>) -> Void) {
        var cancellable: AnyCancellable?
        cancellable = Combine.doSomethingThrowing()
            .sink { subscriptionCompletion in
                switch subscriptionCompletion {
                case let .failure(error):
                    completion(.failure(error))
                case .finished:
                    break
                }
                _ = cancellable // this is simply to ignore Swift's warning `Variable 'cancellable' was written to, but never read`
                cancellable = nil
            } receiveValue: { value in
                completion(.success(value))
            }
    }

}

// MARK: Closures to Async/Await
enum ClosuresToAsyncAwait {

    static func doSomething() async -> String {
        await withCheckedContinuation { continuation in
            Closures.doSomething {
                continuation.resume(returning: $0)
            }
        }
    }

    static func doSomethingThrowing() async throws -> String {
        try await withCheckedThrowingContinuation { continuation in
            Closures.doSomethingThrowing {
                continuation.resume(with: $0)
            }
        }
    }

    static func doSomethingMore() -> AsyncStream<String> {
        AsyncStream { continuation in
            Closures.doSomethingMore { value in
                continuation.yield(value)
            }
        }
    }

    static func doSomethingMoreThrowing() -> AsyncThrowingStream<String, Error> {
        AsyncThrowingStream { continuation in
            Closures.doSomethingMoreThrowing { value in
                switch value {
                case let .success(success):
                    continuation.yield(success)
                case let .failure(error):
                    continuation.yield(with: .failure(error))
                }
            }
        }
    }

}

// MARK: Closures to Combine
enum ClosuresToCombine {

    static func doSomething() -> Future<String, Never> {
        Future { promise in
            Closures.doSomething {
                promise(.success($0))
            }
        }
    }

    static func doSomethingThrowing() -> Future<String, SomeError> {
        Future { promise in
            Closures.doSomethingThrowing {
                promise($0)
            }
        }
    }

    static func doSomethingMore() -> AnyPublisher<String, Never> {
        AnyPublisher { subscriber in
            Closures.doSomethingMore {
                _ = subscriber.receive($0)
            }
            return nil
        }
    }

    static func doSomethingMoreThrowing() -> AnyPublisher<String, SomeError> {
        AnyPublisher { subscriber in
            Closures.doSomethingMoreThrowing { value in
                switch value {
                case let .success(success):
                    subscriber.receive(success)
                case let .failure(error):
                    subscriber.receive(completion: .failure(error))
                }
            }
            return nil
        }
    }

}

