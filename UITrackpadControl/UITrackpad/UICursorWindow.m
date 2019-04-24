//
//  UICursorWindow.m
//  UITrackpad
//
//  Created by Steven Troughton-Smith on 14/07/2018.
//  Copyright © 2018 Steven Troughton-Smith. All rights reserved.
//

#import "UICursorWindow.h"

@implementation UICursorWindow

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
	UIView *hitView = [super hitTest:point withEvent:event];
	
	// If the hitView is THIS view, return nil and allow hitTest:withEvent: to
	// continue traversing the hierarchy to find the underlying view.
	if (hitView == self) {
		return nil;
	}
	// Else return the hitView (as it could be one of this view's buttons):
	return hitView;
}

@end
