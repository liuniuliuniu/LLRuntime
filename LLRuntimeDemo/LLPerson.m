//
//  LLPerson.m
//  LLRuntimeDemo
//
//  Created by liushaohua on 2016/11/16.
//  Copyright © 2016年 liushaohua. All rights reserved.
//


#import "LLPerson.h"




@implementation LLPerson{

    NSString * age;

}

@synthesize name;


- (instancetype)init{
    self = [super init];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    
    self.name = @"奥卡姆剃须刀";
    
    age = @"25";
    

}

- (void)eat{
    
    NSLog(@"吃");
    
}

- (void)run{
    
    NSLog(@"跑");

}

- (NSString *)description{

    
    return [NSString stringWithFormat:@"%@---%@",self.name,age];
}


@end
