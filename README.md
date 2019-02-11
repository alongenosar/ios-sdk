# Getting Started with the Snappers SDK for iOS

## Step 1: Instalation
We currently supports only Swift projects

### CocoPods
Add this to your Podfile 

```ruby
    source 'https://github.com/alongenosar/SnappersSDK-podspec.git'
    source 'https://alongenosar@bitbucket.org/eitan_goldfrad/wowzatrunk.git'
    source 'https://github.com/CocoaPods/Specs.git'
    target 'Your target name' do
    use_frameworks!
 
    pod 'SnappersSDK'
    
    end
```
from the terminal in your project directory type 
```bash
    pod install
```

## Step 2: Configure App Settings
1. In Xcode, from target’s Build Settings tab, set “Enable Bitcode” option to ​ **NO.**
2. from target’s Capabilities tab, enable Push Notifications.
3. from target’s Capabilities tab, under Background modes, enable Location updates and Remote notifications.

## Step 3: Configure permissions by adding the following into your info.plist file
In the Project Navigator, right click on Info.plist, and choose "Open as" → "Source Code"
Paste the following snippet into your existing plist.
```xml
<key>NSAppTransportSecurity</key>
<dict>
	<key>NSAllowsArbitraryLoads</key>
	<true/>
</dict>
<key>NSCameraUsageDescription</key>
<string>We require access in order to record and broadcast videos</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>We require access to your location in order to match relevant events for your location</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>We require access to your location  to find relevant events for you and to validate users content origin</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>We require access to your location  to find relevant events for you and to validate users content origin</string>
<key>NSMicrophoneUsageDescription</key>
<string>We requires access to your microphone in order to record and broadcast videos</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>We require access to your photo library to allow you to upload prerecorded videos</string>   
```

## Step 4: If you plan using Snapper's Facebook or Twitter authentication, add the folowing to your info.plist file 
In the Project Navigator, right click on Info.plist, and click "Open as" → "Source Code"
Paste the following snippet into your existing plist.
```xml   
<key>CFBundleURLTypes</key>
    <array>
        <dict>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>fb1973807389602856</string>
            </array>
        </dict>
        <dict>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>twitterkit-c8k1VkrIs7tHDuHkcc5kzLJAX</string>
            </array>
        </dict>
    </array>
```
## Step 5: Initialize Snappers SDK
Initialize SDK from your ViewController's ​ **viewDidLoad()​ ​** method​.
Check for errors in the callback to ensure successful initialization

**​ViewController.swift**
Swift:
```swift
import SnappersSDK
.
.
.
override func viewDidLoad() {
	SnappersSDK.shared.identify(token: "YOUR TOKEN", secret: "YOUR SECRET") { error in

	}
}
   
```
## Step 6: Present events screen
Once Snappers initialized succsefully, you can present the Map screen as following:

Swift:
```swift
SnappersSDK.shared.present(.mapView, style:.popup) { error in

}
```
## API

```swift
// @discussion Intended for debug purpeses, requests a test invitation notification.
// @param message notification message.
// @param delay the time in seconds before sending the notification request, allowing the tester to recieve the notification while the application is in the background.
// @param callback called when request completed. 

sendTestNotifiction(message:String?,delay:NSTimeInterval = 3,_ callback:((error:String?)->Void))
```

```objectivec
// @discussion Enables invitation notifications from Snappers server.
// @param enabled enable or disable notifications.
// @param callback called when request completed.

-(void) enableNotifications:(BOOL)enabled callback:(void(^)(NSError *error,BOOL result))callback;
```

```objectivec
// @discussion inquire the current notification enable state.
// @param @param callback called with result when request completed.

-(void) isNotificationsEnabled:(void(^)(NSError *error,BOOL result))callback;
```

```objectivec
// @discussion Returns the current Snappers SDK version

@property (readonly) NSString *version;
```




