# MVVMTechnicalTest

## SwiftGen

I use Swiftgen to generate automatically assets and localizable strings. You can run SwiftGen with the following command:
```bash
swiftgen config run --config MVVMTechnicalTest/Resources/swiftgen.yml
```

## SwiftLint

I use swiftlint to keep the code clean and to respect style and conventions. SwiftLint is automatically run every build but you must install it on your machine:
```bash
brew install swiftlint
```

## Swift-format

To keep the code in the same format as I develop. Swift-format is run every commit to ensure the project respect the correct code format.
You must install it by following this tutorial : https://github.com/apple/swift-format
