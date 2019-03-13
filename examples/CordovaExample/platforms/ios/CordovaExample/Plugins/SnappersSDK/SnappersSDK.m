#import "SnappersSDK.h"
@import SnappersSDK;

@implementation SnappersSDK
- (void) echo:(CDVInvokedUrlCommand *)command {
    NSString *message = [command.arguments objectAtIndex:0];
    NSDictionary *jsonObj = @{@"success":@"true",@"message":message};
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
- (void) identify:(CDVInvokedUrlCommand *)command {
    [self.commandDelegate runInBackground:^{
        NSString *token = command.arguments[0];
        NSString *secret = command.arguments[1];
        [SnappersSDK.shared identifyWithToken:token secret:secret :^(NSError * error) {
            if(!error) 
                [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
            else
                [self.commandDelegate sendPluginResult:[self generateErrorResult:error.description] callbackId:command.callbackId];
        }];
    }];
}
- (void) presentView:(CDVInvokedUrlCommand *)command {
    // [self.commandDelegate runInBackground:^{
        NSString *type = command.arguments[0];
        if(![type isEqualToString:@"map"] &&  ![type isEqualToString:@"list"]) {
            [self.commandDelegate sendPluginResult:[self generateErrorResult:@"supported view types are map or list"]  callbackId:command.callbackId];
            return;
        }
        [SnappersSDK.shared present:[type isEqualToString:@"map"] ? SnappersViewMap : SnappersViewEventList :^(NSError * error) {
        if(!error) 
                [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
            else
                [self.commandDelegate sendPluginResult:[self generateErrorResult:error.description]  callbackId:command.callbackId];
        }];
    // }];
}
- (void) socialLogin:(CDVInvokedUrlCommand *)command {
    [self.commandDelegate runInBackground:^{
    NSString *type = command.arguments[0];
    if(![type isEqualToString:@"facebook"] &&  ![type isEqualToString:@"twitter"]) {
            [self.commandDelegate sendPluginResult:[self generateErrorResult:@"supported login types are facebook or twitter"]  callbackId:command.callbackId];
            return;
        }
        [SnappersSDK.shared loginWithMethod:[type isEqualToString:@"facebook"] ? SnappersLoginMethodFacebook : SnappersLoginMethodTwitter :^(NSError * error) {
            if(!error) 
                [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
            else
                [self.commandDelegate sendPluginResult:[self generateErrorResult:error.description]  callbackId:command.callbackId];
        }];
     }];
}
- (void) logoutUser:(CDVInvokedUrlCommand *)command {
     [self.commandDelegate runInBackground:^{
        [SnappersSDK.shared logout :^(NSError * error) {
                if(!error) 
                    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
                else
                    [self.commandDelegate sendPluginResult:[self generateErrorResult:error.description]  callbackId:command.callbackId];
        }];
     }];
}
- (void) requestTestInvitation:(CDVInvokedUrlCommand *)command {
    NSString *eventId = command.arguments[0];
    NSTimeInterval delay = [command.arguments[1] doubleValue];
    if(!eventId) {
        [self.commandDelegate sendPluginResult:[self generateErrorResult:@"eventId parameter missing"] callbackId:command.callbackId];
        return;
    }
    [self.commandDelegate runInBackground:^{
        [SnappersSDK.shared requestBroadcastInvitationWithEventId:eventId delay:delay :^(NSError * error) {
            if(!error) {
            [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
        } else {
            [self.commandDelegate sendPluginResult:[self generateErrorResult:error.description] callbackId:command.callbackId];
        }
        }];
    }];
}
- (void) registeredUserLogin:(CDVInvokedUrlCommand *)command {
    NSString *name = command.arguments[0];
    NSString *userID = command.arguments[1];
    NSString *profilePicture = command.arguments[2];
    if(!name) {
        [self.commandDelegate sendPluginResult:[self generateErrorResult:@"name parameter missing"] callbackId:command.callbackId];
        return;
    }
    [self.commandDelegate runInBackground:^{
        [SnappersSDK.shared loginWithRegisteredUserWithName:name id:userID profilePicture:profilePicture :^(NSError * error) {
            if(!error)
                [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
            else
            [self.commandDelegate sendPluginResult:[self generateErrorResult:error.description] callbackId:command.callbackId];
        }];
     }];
}
-(CDVPluginResult *) generateErrorResult:(NSString *)message {
    return [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary : @{@"error":message}];
}
@end
