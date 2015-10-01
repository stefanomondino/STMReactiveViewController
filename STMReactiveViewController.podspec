#
# Be sure to run `pod lib lint STMReactiveViewController.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "STMReactiveViewController"
  s.version          = "0.4.1"
  s.summary          = "Utilities for UIViewController made simple with ReactiveCocoa signals"
  s.description      = <<-DESC
                       STMReactiveViewController includes a collection of methods that aim to simplify common task such as passing of parameters in storyboard segues, presenting alerts and actionsheets and simple form management.
                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/stefanomondino/STMReactiveViewController"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Stefano Mondino" => "stefano.mondino.dev@gmail.com" }
  s.source           = { :git => "https://github.com/stefanomondino/STMReactiveViewController.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/puntoste'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'STMReactiveViewController' => ['Pod/Assets/*.png']
  }

   s.public_header_files = 'Pod/Classes/**/*.h'
   # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'ReactiveCocoa', '~> 2.0'
end
