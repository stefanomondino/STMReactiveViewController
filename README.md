# STMReactiveViewController


[![Version](https://img.shields.io/cocoapods/v/STMReactiveViewController.svg?style=flat)](http://cocoadocs.org/docsets/STMReactiveViewController)
[![License](https://img.shields.io/cocoapods/l/STMReactiveViewController.svg?style=flat)](http://cocoadocs.org/docsets/STMReactiveViewController)
[![Platform](https://img.shields.io/cocoapods/p/STMReactiveViewController.svg?style=flat)](http://cocoadocs.org/docsets/STMReactiveViewController)


This library provides useful addictions to UIViewController when used with ReactiveCocoa and MVVM pattern. 

## Key features ##

*  Smart segues: use <code>performSegueWithIdentifier:parameters:</code> to set values on segue's destinationViewController. Works with topViewController of UINavigationController. Parameters are set using key-value coding by passing a NSDictionary in the new 'parameters' parameter.

* Convenience <code>performSegueWithIdentifier:viewModel:</code> to set viewModel on destination view controllers with segues

*  Reactive extensions for viewWill/Did Appear/Disappear

* <code>RACSignal</code> to automatically show/hide loader view (customizable!) and errors from <code>RACCommand</code>. A must for MVVM 

* <code>STMReactiveViewModel</code> incapsulates common datasource methods for table views and collection views

## Documentation 

Full documentation is coming. You can take a look at the examples in the meanwhile.



## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS 7.0 and above. 

## Installation

STMReactiveViewController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

pod "STMReactiveViewController"

##

Stefano Mondino, stefano.mondino.dev@gmail.com

## License

STMReactiveViewController is available under the MIT license. See the LICENSE file for more info.

