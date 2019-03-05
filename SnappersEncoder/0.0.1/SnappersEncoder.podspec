Pod::Spec.new do |s|
    s.name              = 'SnappersEncoder'
    s.version           = '0.0.1'
    s.summary           = 'Your framework summary'
    s.homepage          = 'http://www.snappers.tv'
    s.author            = { 'Name' => 'info@snappers.tv' }
    s.license           = 'Proprietary'
    s.platform          = :ios
    s.source            = { :http => 'https://snappers-storage.azureedge.net/assets/0.0.1.zip' }
    s.ios.deployment_target = '9.0'
    s.vendored_frameworks = 'WowzaGoCoderSDK.framework'
end