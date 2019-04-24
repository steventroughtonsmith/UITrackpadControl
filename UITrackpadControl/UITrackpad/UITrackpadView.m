//
//  UITrackpadView.m
//  UITrackpad
//
//  Created by Steven Troughton-Smith on 13/07/2018.
//  Copyright © 2018 Steven Troughton-Smith. All rights reserved.
//

#import "UITrackpadView.h"
#import "UIMouseCursor.h"

@implementation UITrackpadView

+(CAShapeLayer *)_finger
{
	CAShapeLayer *f = [CAShapeLayer layer];
	f.backgroundColor = [UIColor whiteColor].CGColor;
	f.cornerRadius = 22;
	f.bounds = CGRectMake(0, 0, 44, 44);
	f.contents = (__bridge id _Nullable)([UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 44, 44)].CGPath);
	f.opacity = 0;
	
	return f;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
		
		[UIMouseCursor sharedInstance];
		
		self.multipleTouchEnabled = YES;
		
		self.layer.cornerRadius = 38;
		
		finger = [UITrackpadView _finger];
		finger2 = [UITrackpadView _finger];

		finger.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
		finger2.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));

		
		[self.layer addSublayer:finger];
		[self.layer addSublayer:finger2];
	}
	return self;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	[super touchesBegan:touches withEvent:event];
	self.handling = NO;
	
	finger.opacity = 1;
	
	if (touches.count > 1)
	{
		finger2.opacity = 1;
		[[UIMouseCursor sharedInstance] beginScroll];
	}

}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	[super touchesMoved:touches withEvent:event];
	self.handling = YES;
	
	UITouch *firstTouch = [touches allObjects].firstObject;
	UITouch *secondTouch = nil;
	

	CGPoint last = [firstTouch previousLocationInView:nil];
	CGPoint current = [firstTouch locationInView:nil];
	

	if (touches.count > 1)
	{
		secondTouch = [[touches allObjects] objectAtIndex:1];
		finger2.opacity = 1;

		[[UIMouseCursor sharedInstance] scrollByX:(current.x-last.x) Y:(current.y-last.y)];
	}
	else
	{
		[[UIMouseCursor sharedInstance] moveByX:(current.x-last.x) Y:(current.y-last.y)];
	}
	
	[CATransaction begin];
	[CATransaction setDisableActions:YES];
	finger.position = [firstTouch locationInView:self];
	if (touches.count > 1)
		finger2.position = [secondTouch locationInView:self];
	[CATransaction commit];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	[super touchesEnded:touches withEvent:event];

	if (self.handling)
	{
		[[UIMouseCursor sharedInstance] endScroll];
	}
	else
	{
		if (touches.count == 1)
			[[UIMouseCursor sharedInstance] click];
		else if (touches.count == 2)
			[[UIMouseCursor sharedInstance] rightClick];
	}
	
	finger.opacity = 0;
	finger2.opacity = 0;

}

@end
