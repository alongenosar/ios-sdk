//
//  UIColor+More.h
//  fxchallenge
//
//  Created by Alon Genosar on 4/3/14.
//  Copyright (c) 2014 Alon Genosar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MORE)
+(UIColor *) colorWithNumber:(NSUInteger)color;
+(UIColor *) shokingPinkColor;
+(UIColor *) randomColorWithAlpha:(NSUInteger)alpha;
+(UIColor *) randomColor;
//@property (readonly) CGFloat brightness;
@end
