#
# Be sure to run `pod lib lint MTMContactsManager.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "MTMContactsManager"
  s.version          = "0.2.0"
  s.summary          = "A module to access the ios address book and retrieve an array of MTMContact."
  s.description      = "A module to access the ios address book and retrieve an array of MTMContact managing permissions. It returns null if no access will be granted."
  s.homepage         = "https://github.com/manupeco/MTMContactsManager"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "manupeco" => "emanuele.pecorari@gmail.com" }
  s.source           = { :git => "https://github.com/manupeco/MTMContactsManager.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

s.source_files = 'MTMContactsManager/*.{h,m}'
  s.resource_bundles = {
    'MTMContactsManager' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
