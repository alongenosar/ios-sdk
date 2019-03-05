//
//  NewChatViewController.h
//  Snappers
//
//  Created by Alon Genosar on 08/01/2018.
//  Copyright © 2018 Snappers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewChatViewController;
typedef enum {
    nextLine,
    sendMessage,
    sendMessageAndDismmissKeyboard
} EnterKeyBehaviour;
typedef enum {
    baloonLayoutLeft,
    baloonLayoutSpread,
} BaloonsLayout;
@protocol NewChatDelegate
@required
-(void) chatDidUpdate:(NewChatViewController*)chat;
-(void) chatDidChangedBusyState:(BOOL)state;
@end

@interface NewChatViewController : UIViewController
@property (nonatomic,weak) id<NewChatDelegate> delegate;
@property (nonatomic,strong) UIColor *textViewBorderColor;
@property (nonatomic,strong) NSArray *events;
@property (assign,nonatomic) BOOL showMessageBox;
@property (strong,nonatomic) NSString *headerBubble;
@property (assign,nonatomic) EnterKeyBehaviour enterKeyBehaviour;
@property (assign, nonatomic) Boolean autoHide;
@property (assign, nonatomic) BaloonsLayout baloonLayout;
@property (assign, nonatomic) BOOL showSendButton;
@property (strong, nonatomic) UIColor *tintColor;
@property (assign, nonatomic) BOOL tableNeedsRefresh;
@property (strong, nonatomic) UIColor *textViewBackgroundColor;
@property (strong, nonatomic) UIColor *textViewTextColor;
//-(void) scrollToBottom:(BOOL)animated callback:(void(^)(void))callback;
-(void) refresh;
-(void) dismissKeyboard;
@end
