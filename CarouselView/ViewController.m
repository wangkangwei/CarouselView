//
//  ViewController.m
//  CarouselView
//
//  Created by iCount on 16/9/13.
//  Copyright © 2016年 iCount. All rights reserved.
//

#import "ViewController.h"
#import "CarouselView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arr = @[@"hengda1.jpg",@"hengda2.jpg",@"hengda3.jpg",@"hengda4.jpg",@"hengda5.jpg",@"hengda6.jpg"];
    CarouselView *carouselView = [CarouselView carouselViewWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 250) imageNames:arr target:self tapAction:@selector(tapAction:) timeInterval:2.0];
    [self.view addSubview:carouselView];
    carouselView.currentColor = [UIColor greenColor];
    carouselView.otherColor = [UIColor lightGrayColor];
    
}
- (void)tapAction:(UITapGestureRecognizer *)tap {
    NSLog(@"%ld", tap.view.tag);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
