//
//  UITrackpadView.h
//  UITrackpad
//
//  Created by Steven Troughton-Smith on 13/07/2018.
//  Copyright © 2018 Steven Troughton-Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITrackpadView : UIView
{
	CAShapeLayer *finger;
	CAShapeLayer *finger2;
}

@property BOOL handling;
@end

NS_ASSUME_NONNULL_END
