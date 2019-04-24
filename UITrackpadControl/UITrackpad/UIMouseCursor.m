//
//  UIMouseCursor.m
//  UITrackpad
//
//  Created by Steven Troughton-Smith on 13/07/2018.
//  Copyright © 2018 Steven Troughton-Smith. All rights reserved.
//

#import "UIMouseCursor.h"

@implementation UIMouseCursor

+(instancetype)sharedInstance
{
	static UIMouseCursor *sharedInstance = nil;
	static dispatch_once_t onceToken;
	
	dispatch_once(&onceToken, ^{
		sharedInstance = [[UIMouseCursor alloc] init];
	});
	return sharedInstance;
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		
		CGRect b = [UIScreen mainScreen].bounds;
		
		cursorPresentationWindow = [[UICursorWindow alloc] initWithFrame:b];
		cursorPresentationWindow.opaque = NO;
		
		cursor = [CALayer layer];
		
		cursor.position = CGPointMake(CGRectGetMidX(b), CGRectGetMidY(b));
		cursor.bounds = CGRectMake(0, 0, 14, 21);
		cursor.contents = (__bridge id _Nullable)([UIImage imageNamed:@"CursorDefault"].CGImage);
		cursor.zPosition = FLT_MAX;
		
		[cursorPresentationWindow.layer addSublayer:cursor];
		
		[cursorPresentationWindow setHidden:NO];
		[cursorPresentationWindow setWindowLevel:FLT_MAX];
		
		self.acceleration = 6.0;
	}
	return self;
}

-(void)beginScroll
{
	_scrollPosition = cursor.position;
	/* Your code here */
}

-(void)scrollByX:(CGFloat)x Y:(CGFloat)y
{	
	CGPoint oldPosition = _scrollPosition;
	
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wgnu"
	CGFloat accelX = MAX(MIN(fabs(x), self.acceleration), 1.0);
	CGFloat accelY = MAX(MIN(fabs(y), self.acceleration), 1.0);
#pragma GCC diagnostic pop

	CGFloat newX = oldPosition.x + accelX*x;
	CGFloat newY = oldPosition.y + accelY*y;
	
	
	CGPoint possiblePosition = CGPointMake(newX, newY);
	
	_scrollPosition = possiblePosition;
	
	/* Your code here */
}

-(void)endScroll
{
	/* Your code here */
}

-(void)moveByX:(CGFloat)x Y:(CGFloat)y
{
	CGRect b = [UIScreen mainScreen].bounds;

	CGPoint oldPosition = cursor.position;
	
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wgnu"
	CGFloat accelX = MAX(MIN(fabs(x), self.acceleration), 1.0);
	CGFloat accelY = MAX(MIN(fabs(y), self.acceleration), 1.0);
#pragma GCC diagnostic pop

	CGFloat newX = oldPosition.x + accelX*x;
	CGFloat newY = oldPosition.y + accelY*y;
	
	if (newX < 0)
		newX = 0;
	
	if (newY < 0)
		newY = 0;
	
	if (newX > b.size.width)
		newX = b.size.width;
	
	if (newY > b.size.height)
		newY = b.size.height;

	CGPoint possiblePosition = CGPointMake(newX, newY);
	
	if (CGRectContainsPoint(b, possiblePosition))
	{
		[CATransaction begin];
		[CATransaction setDisableActions:YES];
		cursor.position = possiblePosition;
		[CATransaction commit];
	}
}

-(CGPoint)currentPosition
{
	return cursor.position;
}

-(void)rightClick
{
	[self mouseDown];
	[self mouseMoved];

	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[self mouseUp];
	});
}

-(void)click
{
	[self mouseDown];
	[self mouseUp];
}

-(void)mouseDown
{
#if EXAMPLE
	CGPoint cursorPosition = cursor.position;
#endif
	/* Your code here */
}

-(void)mouseMoved
{
	/* Your code here */
}

-(void)mouseUp
{
	/* Your code here */
}


@end
