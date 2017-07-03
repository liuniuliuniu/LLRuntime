//
//  LLPerson+Category.m
//  LLRuntimeDemo
//
//  Created by liushaohua on 2016/11/16.
//  Copyright © 2016年 liushaohua. All rights reserved.
//

#import "LLPerson+Category.h"
#import <objc/runtime.h>


//做为key，字符常量 必须是C语言字符串；
const char * key = "heightKey";

@implementation LLPerson (Category)

//  设置值  要对应一个key
- (void)setHeight:(float)height{
    
    NSNumber *num = [NSNumber numberWithFloat:height];
    
    /*
     第一个参数是需要添加属性的对象；
     第二个参数是属性的key;
     第三个参数是属性的值,类型必须为id，所以此处height先转为NSNumber类型；
     第四个参数是使用策略，是一个枚举值，类似@property属性创建时设置的关键字，可从命名看出各枚举的意义；
     objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
     */
    objc_setAssociatedObject(self, key, num, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

//提取属性的值:
-(float)height{
    NSNumber *number = objc_getAssociatedObject(self, key);
    return [number floatValue];
}




@end
