//
//  ViewController.m
//  LLRuntimeDemo
//
//  Created by liushaohua on 2016/11/16.
//  Copyright © 2016年 liushaohua. All rights reserved.
//

#import "ViewController.h"

#import "LLPerson.h"
#import "LLPerson+Category.h"

#import <objc/message.h>
#import <objc/runtime.h>


@interface ViewController ()

@property(nonatomic, strong)LLPerson *person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.person = [LLPerson new];

}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    [self getClassVariable];
    
//    [self getAllMathod];
    
//    [self changeVariable];
    
//    [self addVariable];

//    [self addMethod];
    
    [self changeMethod];
}


- (void)changeMethod{

    Method method1 = class_getInstanceMethod([self.person class], @selector(eat));
    
    Method method2 = class_getInstanceMethod([self.person class], @selector(run));

    method_exchangeImplementations(method1, method2);
    
    [self.person eat];

}





// 添加新方法
- (void)addMethod{

    class_addMethod([self.person class], @selector(newMethod), (IMP)myAddingFunction, 0);
    
    [self.person performSelector:@selector(newMethod)];

}

int myAddingFunction(id self,SEL _cmd){
    
    NSLog(@"已新增方法 newMethod");
    
    return 1;
}



- (void)addVariable{
    
    self.person.height = 180;
    
    NSLog(@"%lf",self.person.height);
}



// 改变私有变量age的值

- (void)changeVariable{

    
    NSLog(@"改变前的值 %@",self.person);
    
    
    unsigned int count = 0;
    
    Ivar *allList = class_copyIvarList([self.person class], &count);
    
    Ivar ivar = allList[0];
    
    object_setIvar(self.person, ivar, @(18));
    
    NSLog(@"改变后的值 %@",self.person);
    

}



// 获取所有方法
- (void)getAllMathod{

    
    unsigned int count;
    //获取方法列表，所有在.m文件显式实现的方法都会被找到，包括setter+getter方法；
    Method *allMethods = class_copyMethodList([LLPerson class], &count);
    for(int i =0;i<count;i++)
    {
        //Method，为runtime声明的一个宏，表示对一个方法的描述
        Method md = allMethods[i];
        //获取SEL：SEL类型,即获取方法选择器@selector()
        SEL sel = method_getName(md);
        //得到sel的方法名：以字符串格式获取sel的name，也即@selector()中的方法名称
        const char *methodname = sel_getName(sel); NSLog(@"(Method:%s)",methodname);
    
    }
}





// 获取当前加载的所有类名
- (void)getAllClassName{

    unsigned int count = 0;
    
    Class *classes = objc_copyClassList(&count);
    
    NSLog(@"%ud",count);
    
    for (int i = 0; i < count; i++) {
        const char  *name = class_getName(classes[i]);
        
        NSLog(@"%s",name);
    }
    

}


// 获取所有的变量
- (void)getClassVariable{
    
    unsigned int count = 0;
    
    //  获取类的一个包含所有变量的列表 ivar 是一个runtime声明的一个宏是   实例变量的意思
    Ivar *ivars = class_copyIvarList([LLPerson class], &count);
    
    for (int i = 0; i < count; i++) {
        
        // 遍历每一个变量 包括名称和类型
        Ivar ivar = ivars[i];
        
        const char *varialbeName = ivar_getName(ivar);
        
        const char *varialbeType = ivar_getTypeEncoding(ivar);
        
        NSLog(@"name--%s    type:%s",varialbeName,varialbeType);
        
    }

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
