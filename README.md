# Getting Started with the Snappers SDK for iOS

## Step 1: Instalation

### CocoPods
Add this to your Podfile 

```ruby
    source 'https://github.com/Snappers-tv/ios-sdk.git'
    source 'https://github.com/cocoaPods/Specs.git'
    target 'Your target name' do
    use_frameworks!
    inhibit_all_warnings!
 
    pod 'SnappersSDK'
    
    end
```
from the terminal in your project directory type 
```bash
    pod install
```
## Step 2: Obtain SDK token and secret codes.
Snappers identifies developers by their app's bundle id.  
 To create a developer account and obtain the token and secret codes required by the SDK, drop us a message to info@snappers.tv, and include your app's bundle id.


## Step 3: Configure App Settings
1. In Xcode, from the target’s Build Settings tab, set **Enable Bitcode** option to ​ **NO.**
2. In the target’s Capabilities tab, enable **Push Notifications**, **Keychain Sharing** and **Background Modes**.  
3. In the target’s Capabilities tab, under **Background Modes**, enable **Location updates** and **Remote notifications**.

## Step 4: Add required keys to your info.plist file

Snappers requires the following keys to be addded to the info.plist file.  
**Cordova developers might see this file as {PROJECT-NAME}-info.plist**

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
Paste the following snippet into your existing plist. just before the closing tags at the end of the file

```xml
.
.
.
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
.
.
.
</dict>
</plist>
```

## Step 5: Facebook and Twitter authentication (Optional)
If you decide on using Snappers' Facebook or Twitter authentication, We'll require some additional keys in the info.plist file

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

## Step 6: Add 'Strip architecture' script to avoid rejections when deploying to App Store. 
In the target’s **Build Phases** tab add a new script and paste in the following :

```bash
APP_PATH="${TARGET_BUILD_DIR}/${WRAPPER_NAME}"
find "$APP_PATH" -name 'SnappersSDK.framework' -type d | while read -r FRAMEWORK
do
FRAMEWORK_EXECUTABLE_NAME=$(defaults read "$FRAMEWORK/Info.plist" CFBundleExecutable)
FRAMEWORK_EXECUTABLE_PATH="$FRAMEWORK/$FRAMEWORK_EXECUTABLE_NAME"
echo "Executable is $FRAMEWORK_EXECUTABLE_PATH"

EXTRACTED_ARCHS=()

for ARCH in $ARCHS
do
echo "Extracting $ARCH from $FRAMEWORK_EXECUTABLE_NAME"
lipo -extract "$ARCH" "$FRAMEWORK_EXECUTABLE_PATH" -o "$FRAMEWORK_EXECUTABLE_PATH-$ARCH"
EXTRACTED_ARCHS+=("$FRAMEWORK_EXECUTABLE_PATH-$ARCH")
done

echo "Merging extracted architectures: ${ARCHS}"
lipo -o "$FRAMEWORK_EXECUTABLE_PATH-merged" -create "${EXTRACTED_ARCHS[@]}"
rm "${EXTRACTED_ARCHS[@]}"

echo "Replacing original executable with thinned version"
rm "$FRAMEWORK_EXECUTABLE_PATH"
mv "$FRAMEWORK_EXECUTABLE_PATH-merged" "$FRAMEWORK_EXECUTABLE_PATH"

done
```

## Step 7: Add this line in your AppDelegate class
This allows Snappers to determine if application was launched from a invitation notification
```swift 
import SnappersSDK
.
.
.
func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        SnappersSDK.shared.handleNotification(userInfo: userInfo)
}

```
## Step 8: Initialize Snappers SDK
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
- (void)viewDidLoad {
    [SnappersSDK.shared identifyWithToken:@"YOUR TOKEN" secret:@"YOUR SECRET" :^(NSError * error) {
        NSLog(@"error %@",error);
     }];
 }
```

## Step 8: Present events-map view
Once initialized succsefully, you can present the events-map view as follows:

Swift:  
```swift

SnappersSDK.shared.present(.map) { error in
    print("error \(String(describing:error))")
}

```
Objective-C:  
``` Objective-C
[SnappersSDK.shared present:SnappersViewMap :^(NSError * error) {
    NSLog(@"error %@",error);
}]
```

## Step 9: Test event invitation notification:
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

// @discussion Initialize SnappersSDK. sould be called only once before any other SDK call
// @param token account token as received from Snappers support team
// @param secret account secret as received from Snappers support team
// @param callback(error) finished callback

func identify( token:String, secret:String, _ callback:SnappersCallback? = nil)

```

```swift

// @discussion Presents Snappers view
// @param currently the only view available is .map
// @param callback(error) finished callback

func present(_ screen:SnappersView, _ callback:SnappersCallback?  = nil)

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




