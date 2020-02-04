//
//  MyThread.h
//  runloop_线程保活
//
//  Created by Jason on 2020/2/4.
//  Copyright © 2020 友邦创新资讯. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MyThreadBlock)(void);
@interface MJPermenantThread : NSObject

/**
 封装执行的任务
 */
- (void)execute:(MyThreadBlock)task;
/**
 线程停止
 */
- (void)stop;
@end

