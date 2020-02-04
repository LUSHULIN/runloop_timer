//
//  ViewController.m
//  runloop_线程保活
//
//  Created by Jason on 2020/2/4.
//  Copyright © 2020 友邦创新资讯. All rights reserved.
//

#import "ViewController.h"
#import "MJPermenantThread.h"

@interface ViewController ()
@property (nonatomic,strong)MJPermenantThread *mt;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mt = [[MJPermenantThread alloc] init];
    [self.mt execute:^{
        NSLog(@"下载小电脑");
    }];
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.mt stop];
}

@end
