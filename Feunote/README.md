
# Framework
## Combine
[Using Combine](https://heckj.github.io/swiftui-notes/index_zh-CN.html#aboutthisbook)
[Swiftui-notes Demo](https://github.com/heckj/swiftui-notes)
[Combine: Asynchronous Programming with Swift](https://www.raywenderlich.com/books/combine-asynchronous-programming-with-swift/v2.0/)
[Comparing lifecycle management for async sequences and publishers](https://www.donnywals.com/comparing-lifecycle-management-for-async-sequences-and-publishers/)
## AWS Amplify
[Blogs from AWS](https://aws.amazon.com/blogs/mobile/)
### Cognito
### DataStore
### Storage
### GraphQL
These is a fruastrating issue in codegen tools. it will not show custom postID field in the generated models when we use oneToMany relationship
[The issue of codegen models](https://stackoverflow.com/questions/70772111/amplify-id-for-a-belongto-to-one-relationship-not-in-the-generated-typescript)
[talk about the general of appsync & graphql](https://youtu.be/bRnu7xvU1_Y)
## Kingfisher

# Architecture
~~Clean architecture may overkill for client apps because business logic shall be implemented on server for safety.~~

## Clean Architecture
better unit testing
Figure:
![architecture][https://github.com/developersancho/JetRorty.Android/raw/V2/art/architecture.png]
Form Learn Architecure inventor Uncle Bob:
[The Clean Code Blog by Robert C. Martin (Uncle Bob)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)


This is a by far the most straightforward practive of clean architecture:
[Clean Architecture: iOS App](https://paulallies.medium.com/clean-architecture-ios-app-100539550110)


This is another good implementation of clean architecture but i think is less intuitive than the former one:[clean-architecture-swiftui](https://github.com/nalexn/clean-architecture-swiftui/tree/mvvm)

Another good source code , but in Korean, to be inspected[CleanArchitecture for SwiftUI with Combine, Concurrency](https://github.com/mind0w/HelloCleanArchitectureWithSwiftUI?ref=iosexample.com)

To be inspected[Modern MVVM iOS App Architecture with Combine and SwiftUI](https://www.vadimbulavin.com/modern-mvvm-ios-app-architecture-with-combine-and-swiftui/)
### Dependency Inject (DI)

### Common
Shared Utils are stored here
- Design System
- ImagePicker
### Feature specific
#### Data
Data layer contains the method to get data from data source/apis. it is not relate to business logic. It gives the operation interface to domain use cases. database access, api access , shared preference access

repository (implementation) is the coordinator between data source and usecases. it decide read from source or cache, it maps/transform the data from source to shape which can be used by usecase (but is usually overlooked?)
    *here we change either combine style or completion handler style to async await style?*
    [check here](https://wwdcbysundell.com/2021/wrapping-completion-handlers-into-async-apis/)
    [here](https://www.swiftbysundell.com/articles/creating-combine-compatible-versions-of-async-await-apis/)
#### Domain
Domain layer contains the business logic. It does not relate to views, view status and specific backend api/services. It holds the repository interface and usecases based on the repository interface. It also handles the data validation...
    filtering the list, sort, 
    UseCases is the truely bussiness logic and only contains one public function usually .execute .invoke. It hides the repository interface to presentation layer.
#### Presentation
Presentation layer contains views and viewmodels, it does not hold any business logic, it only contains view components and status. It also invokes the usecases when user interact with the view
### Programmatic Navigation

## Error Handling 

[Responsible Error Handling In SwiftUI](https://www.youtube.com/watch?v=dpmy-msRlCA)
A good solution to overcome the break of clean architecture if introduce user-friendly error handling

[Error handling in Clean Architecture](https://levelup.gitconnected.com/error-handling-in-clean-architecture-9ff159a25d4a)

[Error Handling with Combine and SwiftUI: How to handle errors and expose them to the user]https://peterfriese.dev/posts/swiftui-combine-networking-errorhandling/
## Unit Testing

## Deployment


### Amplify
Offical Blog: [Front-End Web & Mobile]https://aws.amazon.com/blogs/mobile/

How to accelerate your service access in China: [AWS中国和海外网络加速方案](https://zhuanlan.zhihu.com/p/110737132)

API Security: [GraphQL API Security with AWS AppSync and Amplify](https://aws.amazon.com/fr/blogs/mobile/graphql-security-appsync-amplify/)



## Module Implementation best practice and reference
[Building a serverless real-time chat application with AWS AppSync](https://aws.amazon.com/blogs/mobile/building-a-serverless-real-time-chat-application-with-aws-appsync/)

## Issues & Bug Solving
### one-one and one-many bidirectional association in Swift
This blog post describe why the one-to-one model codegened by aws amplify cli throws error but one-to-many doesn't
https://medium.com/@leandromperez/bidirectional-associations-using-value-types-in-swift-548840734047
### Completion Handler vs. Async/Await vs. Combine
A good comparsion and best practive recommendation
[Asynchronous programming with SwiftUI and Combine
The Future of Combine and async/await]https://peterfriese.dev/posts/combine-vs-async/
[Async Await Tutorial](https://www.raywenderlich.com/25013447-async-await-in-swiftui)

By far the most intuitive instruction to convert completion handler to async api: [Wrapping completion handlers into async APIs]https://wwdcbysundell.com/2021/wrapping-completion-handlers-into-async-apis/
### TaskGroup
applied in the usecases for query multiple images/audios concurrently
https://www.donnywals.com/running-tasks-in-parallel-with-swift-concurrencys-task-groups/

### withCheckedContinuation
used in the repository implementation to wrap the completion handler to async function
### manageing self and anycancelleable instance
[Managing self and cancellable references when using Combine](https://www.swiftbysundell.com/articles/combine-self-cancellable-memory-management/)

### Async Await vs. Completion Handler vs. Combine and Their Interface between each other
Great Source !
https://quickbirdstudios.com/blog/async-await-combine-closures/

### Binding<T?> to Binding<T> 
https://stackoverflow.com/questions/58297176/how-can-i-unwrap-an-optional-value-inside-a-binding-in-swift
# Design System

[How to build design system with SwiftUI]https://medium.com/swlh/build-design-system-with-swiftui-b652d360ab73
some good blog post
https://medium.com/lllllinli/swiftui-how-to-build-design-system-6a73b477b888
## iOS Style Modifiers
// https://developer.apple.com/documentation/swiftui/view-styles


#  Tools
This should be checked for best practice
https://blog.canopas.com/1-min-guide-to-ios-development-best-practices-in-2022-e3f1d009cfa1
## SwiftLint
## SwiftFormat
## xiblint or linter ?
Add restrictions

In order for the color system to stay clean over time, we need to put some restrictions in place. Linters help a lot in this case. I'd highly recommend linters to consider any usages of UIColor initializers to produce warnings. This way, your team is forced to use the colors from the new system. There are tools like xiblint made by folks at Lyft, which is a tool for linting storyboard and xib files. You can add rules to XIBs such as named_colors which allows only named colors and not any custom colors.


# Recommended Online Course or Resource
[Swift Thinking Youtube Channel](https://www.youtube.com/c/SwiftfulThinking)
This Youtuber has a great begining level course on Undemy. His teching style is professional and consistent. His Youtube channel is also very intuitive and complete cover every part of swiftui.

[Kavsoft Youtube Channel]https://www.youtube.com/c/Kavsoft
Great youtuber share his code practive of fancy and latest components, visual effect and also some dedicated full app examples. subscribe his patreon to support

[Paul Hudson Youtube Channel]https://www.youtube.com/c/PaulHudson
long experienced ios developer. Subscribe to get the latest thoughts and updates on ios development

[DesignCode Youtube Channel](https://www.youtube.com/c/DesignCodeTeam)
Great at combining UI design with Code implementation. Although sometimes its code and UI design is not implemented with best practice. But the final product looks like a charm.

[Firebase](https://www.youtube.com/c/firebase)
yeah, the firebase, you need it to be serverless
[Figma](https://www.youtube.com/c/Figmadesign)
yeah, a good product manager shall know both design and code. Figma is the new standard tool in UI design.

[Into Design Systems](https://www.youtube.com/c/DesignFriendsIntoDesignSystems/videos)
design systems related
[RETHINK](https://www.youtube.com/c/RETHINKHQ)
design system related. many big name's designer shared their thoughts when work on design system


# Other resources to make you relax
[Call of Duty](https://www.youtube.com/c/CallofDuty)
[God of War and Sound Track](https://music.apple.com/cn/album/god-of-war-playstation-soundtrack/1370190783?l=en)
[Seán Doran](https://www.youtube.com/c/SeánDoran)
