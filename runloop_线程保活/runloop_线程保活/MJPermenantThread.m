//
//  MyThread.m
//  runloop_线程保活
//
//  Created by Jason on 2020/2/4.
//  Copyright © 2020 友邦创新资讯. All rights reserved.
//

#import "MJPermenantThread.h"

@interface MyThread : NSThread

@end

@implementation MyThread

- (void)dealloc {
    NSLog(@"线程销毁了---%s",__func__);
}
@end

@interface MJPermenantThread()
//内部线程
@property (strong,nonatomic)MyThread *mjThread;
//标注是否停止下城
@property (assign,nonatomic,getter=isStop) BOOL stop;

@end

@implementation MJPermenantThread

- (instancetype)init {
    if (self = [super init]) {
        self.stop = NO;
        __weak typeof(self)weakSelf = self;
        self.mjThread = [[MyThread alloc] initWithBlock:^{
            NSLog(@"线程创建");
        //创建source1
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
            while (weakSelf && !weakSelf.isStop) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
        }];
        [self.mjThread start];
    }
    return self;
}

- (void)execute:(MyThreadBlock)task {
    if (!self.mjThread || !task) return;
    
    [self performSelector:@selector(__execute:) onThread:self.mjThread withObject:task waitUntilDone:NO];
    
}

- (void)__execute:(MyThreadBlock)task {
    task();
}

- (void)stop {
    if (!self.mjThread) return;
    
    [self performSelector:@selector(__stop) onThread:self.mjThread withObject:nil waitUntilDone:YES];
}

- (void)__stop {
    self.stop = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.mjThread = nil;
}
@end
