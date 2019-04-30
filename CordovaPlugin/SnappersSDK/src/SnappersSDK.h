
#import <Cordova/CDVPlugin.h>
NS_ASSUME_NONNULL_BEGIN
@interface SnappersSDK : CDVPlugin
- (void) echo:(CDVInvokedUrlCommand *)command;
- (void) getVersion:(CDVInvokedUrlCommand *)command;
- (void) identify:(CDVInvokedUrlCommand *)command;
- (void) presentView:(CDVInvokedUrlCommand *)command;
- (void) logoutUser:(CDVInvokedUrlCommand *)command;
- (void) socialLogin:(CDVInvokedUrlCommand *)command;
- (void) requestTestInvitation:(CDVInvokedUrlCommand *)command;
- (void) registeredUserLogin:(CDVInvokedUrlCommand *)command;
@end
NS_ASSUME_NONNULL_END
