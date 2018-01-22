# Getting Started with the Snappers SDK for iOS

## Step 1: Generate an APN .p12 certificate

1. Create a APN .p12 certificate. you can follow the instructions here: https://medium.com/@ankushaggarwal/generate-apns-certificate-for-ios-push-notifications-85e4a917d522 .
 * Note that when you convert Apple's APN .cer file to .p12, in the Keychain Access, its important that you only select the certificate and not its private-key child.
2. Send us the APN certificate along with it's password and your app bundle id to info@snappers.tv .
3. We will send you back a file named Snappers.plist to use in the next step.

## Step 2: Configure App Settings

1. Drag Snappers.plist file (sent with this SDK), to your Project navigator window, make sure “Copy item if
    needed” and your target is selected.
2. From target’s Build Settings tab, set “Enable Bitcode” option to ​ **NO.**
3. From target’s Capabilities tab, enable Push Notifications.
4. From target’s Capabilities tab, under Background modes, enable Location updates.

## Step 3: Add Snappers SDK to your Project

From target’s General tab, add the SnappersSDK.framework to the Embedded Binaries box.

## Step 4: Configure Project’s info.plist file

In the Project Navigator, right click on Info.plist, and click "Open as" → "Source Code"
Paste the following snippet into your existing plist.
```xml
      
<key>CFBundleURLTypes</key>
    <array>
        <dict>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>fb229629484133090</string>
            </array>
        </dict>
        <dict>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>twitterkit-hLVnrpguWOeRUsYsmxVdCIoBu</string>
            </array>
        </dict>
    </array>
    <key>NSCameraUsageDescription</key>
    <string>We require your camera for broadcasting videos</string>
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>We require your location so we can invite you to broadcast events near you</string>
     <key>NSLocationAlwaysUsageDescription</key>
    <string>We require your location so we can invite you to broadcast events near you</string>
    <key>NSMicrophoneUsageDescription</key>
    <key>NSMicrophoneUsageDescription</key>
    <string>We require your microphone for broadcasting videos</string>

    <key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true/>
    </dict>
    
```
## Step 5: Initialize Snappers

You need to initialize Snappers in your AppDelegate class.
Add the following code to your AppDelegate.m file inside ​ **application didFinishLaunchingWithOptions​ ​** method​.
*Note that it’s important that you initialize snappers before anything else

Swift:
```swift
import SnappersSDK

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      
    Snappers.sharedInstance()
    .
    .
    .

}
```
Objective-C
```objectivec
#import <SnappersSDK/SnappersSDK.h>

- (​BOOL​)application:(​UIApplication​ *)application didFinishLaunchingWithOptions:(​NSDictionary​ *)launchOptions {
      
      [Snappers sharedInstance];
      .
      .
      .
}
```

## Step 6: Test Snappers

Snappers SDK is invoked automatically by reacting to push notifications. Go ahead and test it. Connect the follwing code to a button tap action in you ViewController class.

Swift:
​ **​ViewController.swift**
```swift
import UIKit
import SnappersSDK

class ViewController: UIViewController {

    @IBAction func sendTestNotification(_ sender: Any) {

        Snappers.sharedInstance().sendTestNotification("Hello from Snappers", delay: 2) { (error) in
            if error == nil {
                print("Test notification sent successfully")
            }
            else {
                print("Test notification sent error: \(String(describing: error))")
            }
        }
    }
}
```
​ **​ViewController.m**
```objectivec
#import "ViewController.h"
#import <SnappersSDK/SnappersSDK.h>

@implementation​ ​ViewController

- (IBAction)sendTestNotification:(id)sender {
  
    [[Snappers sharedInstance] sendTestNotification:@"Hello from Snappers" delay:2 callback:^(NSError *error) {
        if(!error)
            NSLog(@"Test notification sent successfully");
        else
            NSLog(@"Test notification sent error: %@",error);
    }];
}
```

## API

Swift:
+ (instancetype) sharedInstance;
-(void) sendTestNotification:(NSString *)text delay:(NSTimeInterval)delay callback:(void(^)(NSError *error))callback;
-(void) isNotificationsEnabled:(void(^)(NSError *error,BOOL result))callback;
-(void) enableNotifications:(BOOL)enabled callback:(void(^)(NSError *error,BOOL result))callback;
-(void) signout:(void(^)(NSError *error))callback;
@property (readonly) NSString *version;
