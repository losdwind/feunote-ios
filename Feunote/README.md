
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
## Kingfisher

# Architecture
## MVVM + Repository
[clean-architecture-swiftui](https://github.com/nalexn/clean-architecture-swiftui/tree/mvvm)

## Deployment
How to accelerate your service access in China
https://zhuanlan.zhihu.com/p/110737132

## Issues & Bug Solving
## one-one and one-many bidirectional association in Swift
This blog post describe why the one-to-one model codegened by aws amplify cli throws error but one-to-many doesn't
https://medium.com/@leandromperez/bidirectional-associations-using-value-types-in-swift-548840734047

# Design System
some good blog post
https://medium.com/lllllinli/swiftui-how-to-build-design-system-6a73b477b888
## iOS Style Modifiers
// https://developer.apple.com/documentation/swiftui/view-styles


#  Tools
## SwiftLint
## SwiftFormat
## xiblint or linter ?
Add restrictions

In order for the color system to stay clean over time, we need to put some restrictions in place. Linters help a lot in this case. I'd highly recommend linters to consider any usages of UIColor initializers to produce warnings. This way, your team is forced to use the colors from the new system. There are tools like xiblint made by folks at Lyft, which is a tool for linting storyboard and xib files. You can add rules to XIBs such as named_colors which allows only named colors and not any custom colors.
