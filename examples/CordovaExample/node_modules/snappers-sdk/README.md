# Getting Started with the Snappers SDK for iOS

## Step 1: Instalation
1. Add iOS platform to your project. From command line, in your project directory, run the following:
```bash
cordova platform add ios
```
2. Open Xcode's workspace found in {PROJECT-NAME}/plaform/ios/{PROJECT-NAME}.xcworkspace. 
3. Create a Swift Bridiging header: The simpliest way to do that is to create a new empty **Swift** class in your xCode project. xCode should present a dialog suggesting to add a bridging header. You should accept.
5. Clear Cordova's cache before xCode build: In xCode, add a new script to the target's Build Phases tab, and paste the following line. **Make sure the script runs first in order by dragging it to the top of the Build Phases list**.
```bash
cordova prepare ios
```

5. Install Cocopods. From command line:

```bash
$ sudo gem install cocoapods
```

6. Install SnappersSDK plugin. From the command line, in your project directory, run the following:

```bash
$ cordova plugin add snappers-sdk
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
## Step 6: Initialize Snappers SDK
In www/js/index.js, add the following code to your **onDeviceReady** function. Use the token and code recieved from Snappers to initialize the SDK. **Check for errors in the callback to ensure successful initialization**
```javascript
onDeviceReady: function() {
    .
    .
    .
    SnappersSDK.identify("TOKEN","SECRET",error => {
        if(error) 
            alert(error)
    })
}
```

## Step 7: Present events-map view
Once initialized succsefully, you can present the events-map view as following:
```javascript
SnappersSDK.presentView("map",(error)=> {
    if(error) 
        alert(error)
})
```
## Step 8: Test event invitation notification:
For testing purposes only, you can mockup a broadcast invitation notification.
Ask Snappers team for an event id required by this action. 
In this example we set the notification delay parameter to 5.0 seconds. 
```javascript
 SnappersSDK.requestTestInvitation("EVENT ID",5.0, (error)=> {
    if(error)
        alert(error)
})
```
# API
```javascript
// @discussion Initialize SnappersSDK. sould be called only once before any other SDK call
// @param token account token as received from Snappers support team
// @param secret account secret as received from Snappers support team
// @param optional callback(error) finished callback
function identify(token, secret, callback)
```  
  
```javascript
// @discussion Presents Snappers view
// @param view, available options "map", "list"
// @param optional callback(error) finished callback
function presentView(view, callback)
```

```javascript
// @discussion Login via social platform
// @param method available options: .facebook and .twitter
// @param optional callback(error) finished callback
function login(method, callback)
```

```javascript
// @discussion Login via custom parameters provided by developer
// @param name display name
// @param optional id custom id 
// @param optional profilePicture path to profile picture url
// @param optional callback(error) finished callback
function loginRegisteredUser( name, id , profilePicture, callback) {
```
```javascript
// @discussion Logout
// @param optional callback(error) finished callback
function logout(callback) 
```

```javascript
// @discussion Request A mockup invitation NOTIFICATION *this is for testing purposes only
// @param eventId - Request an event id from Snappers team
// @param optional delay - The time interval in seconds before sending the notification
// @param optional callback(error) finished callback
function requestBroadcastInvitation(eventId, delay,callback) 
```