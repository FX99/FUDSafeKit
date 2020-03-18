#
# Be sure to run `pod lib lint SafeKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FUDSafeKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of SafeKit.'

  s.description      = <<-DESC
Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/FX99/FUDSafeKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'fudolan' => 'fudolan@163.com' }
  s.source           = { :git => 'https://github.com/FX99/FUDSafeKit.git', :tag => s.version.to_s }
  # s.source           = { :path => 'SafeKit/', }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'FUDSafeKit/**/*.{h,m,mm,c,cpp}'

  # s.resources = 'FUDSafeKit/**/*.{plist,xcassets,bundle,xib}'
  
  # s.resource_bundles = {
  #   'SafeKit' => ['SafeKit/Assets/*.png']
  # }

  # 打包后需要开源的头文件
  s.public_header_files = 'FUDSafeKit/**/*.h'

  # s.frameworks = 'UIKit', 'MapKit'

  # 依赖的第三方库
  # s.dependency 'AFNetworking', '~> 2.3' 
end
