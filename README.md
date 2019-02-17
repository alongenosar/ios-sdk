# Getting Started with the Snappers SDK for iOS

## Step 1: Instalation

### CocoPods
Add this to your Podfile 

```ruby
    source 'https://github.com/Snappers-tv/ios-sdk.git'
    source 'https://github.com/cocoaPods/Specs.git'
    target 'Your target name' do
    use_frameworks!
 
    pod 'SnappersSDK'
    
    end
```
from the terminal in your project directory type 
```bash
    pod install
```
## Step 2: Obtain SDK token and secret codes.
Snappers identify developers by their app's bundle id.  
 To create a developer account and obtain the SDK token and secret codes required by the SDK, drop us a message to info@snappers.tv, and include your app's bundle id.


## Step 3: Configure App Settings
1. In Xcode, from the target’s Build Settings tab, set “Enable Bitcode” option to ​ **NO.**
2. In the target’s Capabilities tab, enable Push Notifications.
3. In the target’s Capabilities tab, under Background modes, enable Location updates and Remote notifications.

## Step 4: Add required keys to your info.plist file

Snappers requires the following keys to be addded to the info.plist file

- Privacy - Camera Usage Description : Add description
- Privacy - Location When In Use Usage Description : Add description
- Privacy - Location Always Usage Description : Add description
- Privacy - Location Always and When In Use Usage Description : Add description
- Privacy - Microphone Usage Description : Add description
- Privacy - Photo Library Usage Description : Add description
- App Transport Security Settings
	* Allow Arbitrary Loads : YES
	
Either add them manually one by one, or use the following instructions to add them collectively:

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

## Step 5: Facebook and Twitter authentication (Optional)
If you decide on using Snappers' Facebook or Twitter authentication, We'l require some additional keys in the info.plist file

- URL types
	* item
		- URL Schemes
			- URL identifier : Facebook
			- item : fb1973807389602856
	* item
		- URL Schemes
			- URL identifier : Twitter
			- item : twitterkit-c8k1VkrIs7tHDuHkcc5kzLJAX


Either add them manually one by one, or use the following instructions to add them collectively:

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
## Step 6: Initialize Snappers SDK
From your ViewController's ​**viewDidLoad​​** method​, use the token and code obtained in stage 2, to initialize the SDK.  
Check for errors in the callback to ensure successful initialization

Swift:  
**​ViewController.swift**
```swift
import SnappersSDK
.
.
.
override func viewDidLoad() {
    SnappersSDK.shared.identify(token: "YOUR TOKEN", secret: "YOUR SECRET") { error in
	print("error \(String(describing:error))")
    }
}
   
```
Objective-C:  
**​ViewController.m**
``` objective-c
@import SnappersSDK;
.
.
.
[SnappersSDK.shared identifyWithToken:@"YOUR TOKEN" secret:@"YOUR SECRET" :^(NSError * error) {
    NSLog(@"error %@",error);
 }];

```
## Step 7: Present events-map view
Once initialized succsefully, you can present the events-map view as follows:

Swift:  
```swift

SnappersSDK.shared.present(.map, style:.fullscreen) { error in
    print("error \(String(describing:error))")
}

```
Objective-C:  
``` Objective-C

[SnappersSDK.shared present:SnappersViewMap style:SnappersPresentationStyleFullscreen :^(NSError * error) {
    NSLog(@"error %@",error);
}]

```

## Step 8: Test event invitation notification:
For testing purposes only, you can mockup a broadcast invitation notification

Swift:
```swift

SnappersSDK.shared.requestBroadcastInvitation(eventId: "EVENT ID") { error in
     print("error \(String(describing:error))")
}

```

Objective-C:  
```Objective-c

 [SnappersSDK.shared requestBroadcastInvitationWithEventId:@"EVENT ID" delay:5.0 :^(NSError * error) {
     NSLog(@"error %@",error);
 }];

```

# API

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
// @param style available options currenttly .fullscreen
// @param callback(error) finished callback

func present(_ screen:SnappersView, style:SnappersPresentationStyle = .fullscreen, _ callback:SnappersCallback?  = nil)

```

```swift

// @discussion Dismisses on-screen view 

func dismissCurrentView()

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

// @discussion Request mockup invitation *this is for testing purposes only*
// @param eventId request event id from Snappers team
// @param delay time interval before sending the notification to allow tester to close application
// @param callback(error) finished callback

func requestBroadcastInvitation( eventId:String, delay:TimeInterval = 3, _ callback:SnappersCallback?) 

```




