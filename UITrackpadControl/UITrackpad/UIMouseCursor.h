//
//  UIMouseCursor.h
//  UITrackpad
//
//  Created by Steven Troughton-Smith on 13/07/2018.
//  Copyright © 2018 Steven Troughton-Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICursorWindow.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIMouseCursor : NSObject
{
	UICursorWindow *cursorPresentationWindow;
	CALayer *cursor;
	NSInteger pointId;
	NSInteger scrollPointId;

	CGPoint _scrollPosition;
}
+(instancetype)sharedInstance;

@property CGFloat acceleration;

-(CGPoint)currentPosition;

-(void)moveByX:(CGFloat)x Y:(CGFloat)y;

-(void)click;
-(void)rightClick;
-(void)mouseDown;
-(void)mouseMoved;
-(void)mouseUp;

-(void)beginScroll;
-(void)scrollByX:(CGFloat)x Y:(CGFloat)y;
-(void)endScroll;

@end

NS_ASSUME_NONNULL_END
