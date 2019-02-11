# Pod::Spec.new do |s|
#   s.platform     = :ios, "9.0"
#   s.name = 'WowzaGoCoderSDK'
#   s.version = '1.0'
#   s.author = 'Wowza Corp'
#   s.license = 'Proprietary'
#   s.homepage = 'http://www.Snappers.tv'
#   s.summary = 'Chunky bananas!'
#   s.source = {
#     :http => 'https://snappers-storage.azureedge.net/assets/WowzaGoCoderSDK.framework.zip'
#   }
#   #s.ios.vendored_frameworks = 'WowzaGoCoderSDK.framework'
# end

#
Pod::Spec.new do |s|
    s.name              = 'WowzaGoCoderSDK'
    s.version           = '0.0.1'
    s.summary           = 'Your framework summary'
    s.homepage          = 'http://www.snappers.tv'
    s.author            = { 'Name' => 'Alon@Bootleg.co.il' }
    s.license           = 'Proprietary'
    s.platform          = :ios
    s.source            = { :http => 'https://snappers-storage.azureedge.net/assets/0.0.1.zip' }
    s.ios.deployment_target = '9.0'
    s.vendored_frameworks = 'WowzaGoCoderSDK.framework'
end

# Pod::Spec.new do |s|
#   s.name  = "WowzaGoCoderSDK"
#   s.version = "0.1.0" # How it will be listed in Specs repo
#   s.summary = "This pod is to test if pods work for us."
#   s.homepage = "https://judgecardx.com"
#   s.license = { :type => "Commercial", :text => "Do whatever you want"}
#   s.author = { "Johns, Robert" => "rjohns@visa.com" }
#   s.platform = :ios
#   s.ios.deployment_target = "9.0"
#   s.source = { :http => "https://github.com/rajohns08/AdamPodFramework/archive/0.1.0.zip" }
#   s.vendored_frameworks = "AdamPodFramework-0.1.0/AdamPodTest.framework"#{}"AdamPodTest.framework"
#   s.framework = "UIKit"
#   s.requires_arc = true
# end
