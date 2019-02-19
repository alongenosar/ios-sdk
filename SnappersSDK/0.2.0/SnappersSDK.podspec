Pod::Spec.new do |s|
  s.name         = "SnappersSDK"
  s.version      =  "0.2.0"
  s.swift_version = "4.0"
  s.summary      = "SnappersSDK allows developers to integrate Snapper's functionality into their project"
  s.description  = "SnappersSDK allows developers to integrate Snapper's functionality into their project SnappersSDK allows developers to integrate Snapper's functionality into their project"
  s.homepage     = "http://snappers.tv"
  s.author       = { "AlonGenosar" => "alon@bootleg.co.il" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => 'https://github.com/Snappers-tv/ios-sdk.git', :tag => '0.2.0' }
  s.vendored_frameworks = 'SnappersSDK.framework'
  ####s.source_files = 'SnappersSDK/*.swift'
  ####s.static_framework = true
  s.dependency 'AWSS3'
  s.dependency 'WowzaGoCoderSDK'
  s.dependency 'Firebase/Core'
  s.dependency 'Firebase/Auth'
  s.dependency 'Firebase/Database'
  s.dependency 'Firebase/Storage'
  s.dependency 'Firebase/RemoteConfig'
  s.dependency 'Firebase/Messaging'
  s.dependency 'Firebase/DynamicLinks'
  s.dependency 'FirebaseInstanceID'
  s.dependency 'SDWebImage'
  s.dependency 'Sentry'
  s.dependency 'GoogleMaps'
  s.dependency 'GooglePlaces'
  s.dependency 'FLAnimatedImage'
  s.dependency 'EVReflection'
  s.dependency 'UIImageView-Letters'
  s.dependency 'SwipeCellKit'
  s.dependency 'Kingfisher'
  s.subspec 'FBSDKLoginKit' do |sub| sub.dependency 'FBSDKLoginKit', '~> 4.38.0'  end
  s.subspec 'Sentry' do |sub| sub.dependency 'Sentry', '3.12.0' end
  s.subspec 'TwitterKit' do |sub| sub.dependency 'TwitterKit', '1.15.3' end
  ####s.ios.framework  = 'UIKit'
  s.license      = { :type => 'Apache License, Version 2.0', :text => <<-LICENSE
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at
  http://www.apache.org/licenses/LICENSE-2.0
  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
  LICENSE
  }
end
