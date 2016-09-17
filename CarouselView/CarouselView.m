//
//  CarouselView.m
//  CarouselView
//
//  Created by iCount on 16/7/25.
//  Copyright © 2016年 FancyStudio. All rights reserved.
//

#import "CarouselView.h"

@interface CarouselView ()<UIScrollViewDelegate>
/**内部定时器*/
@property (nonatomic, strong) NSTimer *timer;
/**底部scrollView*/
@property (nonatomic, strong) UIScrollView *scrollView;
/**页数控件*/
@property (nonatomic, strong) UIPageControl *pageControl;
/**图片数组*/
@property (nonatomic, strong) NSArray *imageNames;
/**定时器时间间隔*/
@property (nonatomic, assign) NSTimeInterval time;
/** 记录当前页数*/
@property (nonatomic, assign) NSInteger index;

@end

@implementation CarouselView

+ (instancetype)carouselViewWithFrame:(CGRect)frame imageNames:(NSArray *)imageNames target:(id)target tapAction:(SEL)action timeInterval:(NSTimeInterval)timeInterval
{
    return [[self alloc] initWithFrame:frame imageNames:imageNames target:target tapAction:action timeInterval:timeInterval];
}

- (instancetype)initWithFrame:(CGRect)frame imageNames:(NSArray *)imageNames target:(id)target tapAction:(SEL)action timeInterval:(NSTimeInterval)timeInterval
{
    self = [super initWithFrame:frame];
    if (self) {
        self.index = 0;
        NSString *firstImage = imageNames.firstObject;
        NSString *lastImage = imageNames.lastObject;
        NSMutableArray *tempArr = imageNames.mutableCopy;
        [tempArr insertObject:lastImage atIndex:0];
        [tempArr insertObject:firstImage atIndex:imageNames.count+1];
        self.imageNames = tempArr;
        
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        for (NSInteger i = 0; i < _imageNames.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width * i, 0, width, height)];
            imageView.image = [UIImage imageNamed:_imageNames[i]];
            imageView.tag = i+1;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:tap];
            [self.scrollView addSubview:imageView];
        }
        /**底部scrollView*/
        self.scrollView.pagingEnabled = YES;
        self.scrollView.contentSize = CGSizeMake(width * _imageNames.count, height);
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.contentOffset = CGPointMake(width, 0);
        self.scrollView.bounces = NO;
        [self addSubview:self.scrollView];
        /**页数控件*/
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(frame.size.width/3, frame.size.height-20, frame.size.width/3, 20)];
        self.pageControl.numberOfPages = self.imageNames.count-2;
        self.pageControl.tintColor = self.currentColor;
        self.pageControl.pageIndicatorTintColor = self.otherColor;
        [self addSubview:self.pageControl];
        
        self.scrollView.delegate = self;
        self.time = timeInterval;
        [self startTimer];
    }
    return self;
}

- (void)setCurrentColor:(UIColor *)currentColor
{
    _currentColor = currentColor;
    self.pageControl.currentPageIndicatorTintColor = currentColor;
}
- (void)setOtherColor:(UIColor *)otherColor
{
    _otherColor = otherColor;
    self.pageControl.pageIndicatorTintColor = otherColor;
}

- (void)nextPage
{
    self.index++;
    CGFloat width = self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:CGPointMake(width*(self.index+1), 0) animated:YES];
    if (_index == self.imageNames.count-2) {
        _index = 0;
    }
    self.pageControl.currentPage = _index;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollW = self.scrollView.frame.size.width;
    CGFloat offsetX = scrollView.contentOffset.x;
    self.index = offsetX / scrollW - 1;
    if (offsetX > (self.imageNames.count-2+0.5)*scrollW) {
        [scrollView setContentOffset:CGPointMake(scrollW, 0) animated:NO];
    }
    if (offsetX < 0.5*scrollW) {
        [scrollView setContentOffset:CGPointMake(scrollW*(self.imageNames.count-2), 0) animated:NO];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}
- (void)startTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat scrollW = self.scrollView.frame.size.width;
    CGFloat offsetX = self.scrollView.contentOffset.x;
    if (offsetX < 0.5*scrollW) {
        self.pageControl.currentPage = (self.imageNames.count-2);
    }else if (offsetX > (self.imageNames.count-2+0.5)*scrollW){
        self.pageControl.currentPage = 0;
    }else{
        self.pageControl.currentPage = scrollView.contentOffset.x/scrollW-1;
    }
}

@end
