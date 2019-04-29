#
# Be sure to run `pod lib lint WYCardSwipeView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WYCardSwipeView'
  s.version          = '0.1.0'
  s.summary          = 'A short description of WYCardSwipeView.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/407671883@qq.com/WYCardSwipeView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '407671883@qq.com' => '407671883@qq.com' }
  s.source           = { :git => 'https://github.com/407671883@qq.com/WYCardSwipeView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'WYCardSwipeView/**/*'
  
  # s.resource_bundles = {
  #   'WYCardSwipeView' => ['WYCardSwipeView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
