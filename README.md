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
Snappers SDK required the following privecy descriptions in the info.plist file in order to work : 
	
	Privacy - Camera Usage Description
	Privacy - Location When In Use Usage Description
	Privacy - Location Always Usage Description
	Privacy - Location Always and When In Use Usage Description
	Privacy - Microphone Usage Description
	Privacy - Photo Library Usage Description

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
## Step 6: Present events map screen
Once Snappers initialized succsefully, you can present the Snappers map screen as following:

Swift:
```swift

SnappersSDK.shared.present(.mapView, style:.popup) { error in

}

```

## Step 7: Test event invitation notification:
Once Snappers initialized succsefully, you can mockup a broadcase invitation notification

Swift:
```swift

SnappersSDK.shared.requestBroadcastInvitation(eventId: "EVENT ID") { error in

}

```

## API

```swift

// @discussion Initialize SnappersSDK. sould be called only once before any other SDK calls
// @param token account token as received from Snappers support team
// @param secret account secret as received from Snappers support team
// @param callback(error) finished callback

func identify( token:String, secret:String, _ callback:SnappersCallback? = nil)

```

```swift

// @discussion Presents Snappers view
// @param view  available options: .mapView
// @param style available options .fullscreen and .popup
// @param callback(error) finished callback

  func present(_ screen:SnappersView, style:SnappersPresentationStyle = .fullscreen, _ callback:SnappersCallback?  = nil)

```

```swift
// @discussion Login via social platform
// @param view  available options: .facebook and .twitter
// @param callback(error) finished callback

func login( method:SnappersLoginMethod, _ callback:SnappersCallback? = nil)
	
```

```swift

// @discussion Login via custom parameters provided by developer
// @param name display name
// @param id custom id 
// @param profilePicture path to profile picture url
// @param callback(error) finished callback

func loginRegisteredUser( name:String, id:String? = nil, profilePicture:String? = nil, _ callback:SnappersCallback? = nil) {
	
```

```swift

// @discussion Logout
// @param callback(error) finished callback

func logout( _ callback:SnappersCallback? = nil) 
	
```

```swift

// @discussion Logout
// @param eventId request event id from Snappers team
// @param delay time interval before sending the notification to allow tester to close application
// @param callback(error) finished callback

func requestBroadcastInvitation( eventId:String, delay:TimeInterval = 3, _ callback:SnappersCallback?) 

```




