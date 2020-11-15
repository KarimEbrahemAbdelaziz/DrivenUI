<p align="center">
    <img src="https://i.imgur.com/Zd6ipKO.png" width="480” max-width="90%" alt="SwiftyMenu" />
</p>

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.1+-orange.svg"/>
    <a href="https://cocoadocs.org/pods/SwiftyMenu/">
        <img src="http://img.shields.io/badge/Cocoapods-available-green.svg?style=flat" alt="Cocoapod" />
    </a>
    <a href="">
        <img src="http://img.shields.io/badge/Swift%20Package%20Manger-available-green.svg?style=flat" alt="SPM" />
    </a>
    <img src="http://img.shields.io/badge/Version-0.1.0-green.svg?style=flat" alt="Version" />
    <a href="">
        <img src="http://img.shields.io/badge/State-BETA-lightgray.svg?style=flat" alt="MIT License" />
    </a>
    <br>
    <a href="https://www.facebook.com/KarimEbrahemAbdelaziz">
        <img src="http://img.shields.io/badge/Facebook-%40KarimEbrahemAbdelaziz-blue.svg?style=flat" alt="Facebook: @KarimEbrahemAbdelaziz" />
    </a>
    <a href="https://twitter.com/@k_ebrahem_">
        <img src="https://img.shields.io/badge/Twitter-@k_ebrahem_-blue.svg?style=flat" alt="Twitter: @k_ebrahem_" />
    </a>
</p>


# Welcome to DrivenUI SDK
> Honestly, it’s not HTML … But it sort of is. But really, it isn’t.

**DrivenUI** is an iOS SDK which makes introducing and building **Server Driven UI** feature into iOS Applications much more convenient. Currently it's based on **JSON** response format to render **SwiftUI** views on the screen.

⭐️ Star us on GitHub — it helps!

## Table of content
- [Requirments](#requirments)
- [Installation](#installation)
    - [Cocoapods](#cocoapods)
    - [Swift Package Manager](#swift-package-manager)
- [Usage](#usage)
    - [Init SDK](#init-sdk)
    - [Basic Usage](#basic-usage)
    - [Supported Views](#supported-views)
    - [Supported Properties](#supported-properties)
    - [JSON Structure](#json-structure)
- [TODO](#todo)
- [License](#license)

### Requirments
- Xcode 11+
- Swift 5.1+
- Cocoapods 1.9+
- SwiftUI Support Application.

### Installation
#### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate DrivenUI into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'DrivenUI', '~> 0.1.0'
```

#### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development, but Driven does support its use on supported platforms.

Once you have your Swift package set up, adding DrivenUI as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/KarimEbrahemAbdelaziz/DrivenUI.git", .exact("0.1.0"))
]
```

### Usage
#### Init SDK
1. As we're in `BETA` version, please fill an Issue with your application `Bundle Id` and leave your email and we will send you instantly your DrivenUI SDK Key.

2. You have two ways to init DrivenUI in your application.
    - If you are using SwiftUI new application life cycle, add configure method into `init` for your main App.
    - If you are using `AppDelegate`, add configure method into `didFinishLaunchWithOptions` method.

```swift
Driven.configure(with: YUOR_SDK_KEY)
```
#### Basic Usage
Connect to your Backend and retrieve your JSON response (Check supported views [JSON Structure](#json-structure) formats).

Parse your JSON response in your ViewModel:
    
```swift
// Add published property into your ViewModel 
// so that you views can react on it's changes ;)
@Published var serverView: DrivenComponent?

// Parse JSON response from API to DrivenComponent
let response = try? JSONDecoder().decode(DrivenComponent.self, from: data)

if let response = response {
    DispatchQueue.main.async {
        self?.serverView = response
    }
} else {
    DispatchQueue.main.async {
        self?.serverView = nil
    }
}
```
In your Content View add this build function:

```swift
@ViewBuilder func buildView() -> some View {
    if let serverView = viewModel.serverView {
        DrivenComponentFactory(material: serverView).toPresentable()
    } else {
        Text("No views from server.")
    }
}
```

Use this `buildView` inside your view hierarchy:

```swift
var body: some View {
    NavigationView {
        buildView()
            .padding([.top], 48)
        .navigationBarTitle("DrivenUI SDK")
    }
}
```
And **VOILA** you have your views rendered on the screen 🔥

#### JSON Structure
Every supported view component is consist of 4 keys each one take a place based on the Component you need to render:
```swift
{
    // type values are the Supported Views (Please check below section).
    "type": "",
    
    // properties values are pair of key-value of Supported Properties (Please check below section).
    "properties": { },
    
    // values are pair of key-value of Supported Values for each View (Please check below section).
    "values": { },
    
    // subviews values are pair of key-value of another component should be rendered inside one of those views: HStack, VStack, ZStack, and List.
    "subviews": { }
}
```
<br>
<details>
<summary>Text View Example</summary>
<p>
```
{
  "type": "Text",
  "properties": {
    "foregroundColor": "000000",
    "font": "title",
    "fontWeight": "regular",
    "width": 300
  },
  "values": {
    "text": "It's simple version working! 😎"
  }
}
```
</p>
</details>

<details>
<summary>Image View Example</summary>
<p>
```
{
  "type": "Image",
  "properties": {
    "height": 90
  },
  "values": {
    "imageUrl": "https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"
  }
}
```
</p>
</details>

<details>
<summary>HStack View Example</summary>
<p>
```
{
  "type": "HStack",
  "properties": {
    "spacing": 16,
    "verticalAlignment": "top"
  },
  "subviews": [
    {
      "type": "Image",
      "properties": {
        "height": 40,
        "width": 40
      },
      "values": {
        "localImageName": "hiking"
      }
    },
    {
      "type": "VStack",
      "properties": {
        "padding": 8,
        "horizontalAlignment": "leading"
      },
      "subviews": [
        {
          "type": "Text",
          "properties": {
            "font": "title",
            "fontWeight": "bold"
          },
          "values": {
            "text": "Hiking"
          }
        },
        {
          "type": "Text",
          "properties": {
            "foregroundColor": "333333"
          },
          "values": {
            "text": "This is Hiking sport."
          }
        }
      ]
    }
  ]
}
```
</p>
</details>

#### Supported Views
- List
- Image
    - Supported values: 
        - `imageUrl` for retrieving image from URL.
        - `systemIconName` for using system image.
        - `localImageName` for using asset catalog image.
- Text
    - Supported values: 
        - `text` the text value that will be shown.
- Stacks (HStack, VStack, and ZStack)
- Shapes (Rectangle and Circle)
- Spacer and Divider

#### Supported Properties
- `width` and `height`
    - Float value.
- `foregroundColor`, `backgroundColor`, and `borderColor`
    - String value for Color in Hex (e.g. "ffffff").
- `borderWidth`, `spacing` (for HStack and VStack), and `padding`
    - Int value.
- `horizontalAlignment`
    - `leading`
    - `center`
    - `trailing`
- `verticalAlignment`
    - `top`
    - `bottom`
    - `center`
    - `firstTextBaseline`
    - `lastTextBaseline`
- `font`
    - `largeTitle`
    - `title`
    - `headline`
    - `subheadline`
    - `body`
    - `callout`
    - `footnote`
    - `caption`
- `fontWeight` 
    - `ultraLight`
    - `thin`
    - `light`
    - `regular`
    - `medium`
    - `semibold`
    - `bold`
    - `heavy`
    - `black`

### TODO
Please check **_[CHANGELOG](https://github.com/KarimEbrahemAbdelaziz/DrivenUI/blob/main/CHANGELOG.md)_** file for more information to know what's included in each version.
- [ ] Create website for DrivenUI SDK.
- [ ] Setup CI/CD workflows using Bitrise. 
- [ ] Add backward compatibility to JSON views.
- [ ] Support different Operating Systems (tvOS, macOS, and watchOS)
- [ ] Support more views.
- [ ] Support more view modifiers.
- [ ] Support view's actions.
- [ ] Support navigation.
- [ ] Support Protocol Buffers.
- [ ] Document all supported views.
- [ ] Build material components library.
 
### License
- You could find license information **_[HERE](https://github.com/KarimEbrahemAbdelaziz/DrivenUI/blob/main/LICENSE)_**.
