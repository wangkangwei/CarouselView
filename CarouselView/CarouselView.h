//
//  CarouselView.h
//  CarouselView
//
//  Created by iCount on 16/7/25.
//  Copyright © 2016年 FancyStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarouselView : UIView

/**当前圆点的颜色*/
@property (nonatomic, strong) UIColor *currentColor;
/**其他圆点的颜色*/
@property (nonatomic, strong) UIColor *otherColor;

- (instancetype)initWithFrame:(CGRect)frame imageNames:(NSArray *)imageNames target:(id)target tapAction:(SEL)action timeInterval:(NSTimeInterval)timeInterval;

+ (instancetype)carouselViewWithFrame:(CGRect)frame imageNames:(NSArray *)imageNames target:(id)target tapAction:(SEL)action timeInterval:(NSTimeInterval)timeInterval;

@end
