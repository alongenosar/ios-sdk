# Getting Started with the SnappersSDK plugin for Cordova (iOS)

## Step 1: Instalation
1. Add iOS platform to your project. **note that it is crusual that you install ios platform version 5.0.0 or higher**.  
    From command line, in your project directory, run the following:
    ```bash
    cordova platform add ios@5.0.0
    ```
    If you previously installed iOS platform, make sure that you update it to version 5.0.0 or higher as following:
    ```bash
    cordova platform update ios@5.0.0
    ```
    

2. Install SnappersSDK plugin. From the command line, in your project root directory, run the following:

    ```bash
    $ cordova plugin add snappers-sdk
    ```

## Step 2: Obtain SDK token and secret codes and provide us with APNS certificate
Snappers identifies developers by their app's bundle id. 
To create a developer account and obtain the token and secret codes required by the SDK, drop us a message to info@snappers.tv, and include your app's bundle id.  

Snappers SDK works best when sending users invitations to broadcast via push notifications. If you wish to use this feature, we will also need you to include your Apple's push notification certificate.

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

from the xCode project, in the Project Navigator, right click on Info.plist, and choose "Open as" → "Source Code"
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

from the xCode project, in the Project Navigator, right click on Info.plist, and click "Open as" → "Source Code"
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

## Step 7: Add 'Strip architecture' script to avoid rejections when deploying to App Store. 
from the xCode project, In the target’s **Build Phases** tab add a new script and paste in the following :

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

## Step 8: Where from here?
You can  continue to our [step by step API tutorial](https://github.com/Snappers-tv/ios-sdk/blob/master/Documentation/CORDOVA_API.MD)  
Or test SnappersSDK plugin using our Cordova demo app found [here](https://github.com/Snappers-tv/ios-sdk/tree/master/examples/CordovaExample)