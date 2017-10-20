# Keychains

[![Version](https://img.shields.io/cocoapods/v/Keychains.svg?style=flat)](http://cocoadocs.org/docsets/Keychains)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/Keychains.svg?style=flat)](http://cocoadocs.org/docsets/Keychains)
[![Platform](https://img.shields.io/cocoapods/p/Keychains.svg?style=flat)](http://cocoadocs.org/docsets/Keychains)
![Swift](https://img.shields.io/badge/%20in-swift%204.0-orange.svg)

A keychain wrapper that is so easy to use that your cat could use it.

## Usage

```swift
// Save and/or update a password
Keychain.setPassword(password, forAccount: account)

// Get a password
Keychain.password(forAccount:account)

// Delete a password
Keychain.deletePassword(forAccount: account)
```

## Installation

**Keychains** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Keychains'
```

**Keychain** is also available through [Carthage](https://github.com/Carthage/Carthage).
To install just write into your Cartfile:

```ruby
github "hyperoslo/Keychains"
```

## Author

Hyper Interaktiv AS, ios@hyper.no

## License

**Keychains** is available under the MIT license. See the LICENSE file for more info.
