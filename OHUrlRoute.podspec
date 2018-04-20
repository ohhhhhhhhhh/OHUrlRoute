#
# Be sure to run `pod lib lint OHUrlRoute.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OHUrlRoute'
  s.version          = '1.0.1'
  s.summary          = 'A convenient routing tool.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: A convenient routing tool.A convenient routing tool.
                       DESC

  s.homepage         = 'https://github.com/ohhhhhhhhhh/OHUrlRoute'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ohhhhhhhhhh' => 'ohzhangyue@163.com' }
  s.source           = { :git => 'https://github.com/ohhhhhhhhhh/OHUrlRoute.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

# s.source_files = 'OHUrlRoute/Classes/**/*'
  s.source_files = 'Classes/**/*'
  
  s.resource_bundles = {
     'OHUrlRoute' => ['Resources/Images/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
