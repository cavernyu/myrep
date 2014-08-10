//
//  main.m
//  hello
//
//  Created by cavernyu on 13-10-18.
//  Copyright (c) 2013年 cavernyu. All rights reserved.
//

//#import <UIKit/UIKit.h>

//#import "AppDelegate.h"
#define PATH "/Users/yuji"
#import <Foundation/Foundation.h>
#import "Animal.h"
#import "Animal+Animal.h"
#import "Dog.h"
#import "Singleton.h"
#import "Send.h"
#import "Get.h"
#import "Husband.h"
#import "Wife.h"
#import "Son.h"
#import "Mother.h"
#import "Item.h"
#import "List.h"
#import "Human.h"

struct Person
{
    char *name;
    int age;
} person = {"张三", 30};

int main(int argc, char * argv[])
{
    @autoreleasepool {
//        NSMutableString *str = [[NSMutableString alloc] initWithString:@"你好 中国"];
//        NSRange range = NSMakeRange(2, 3);
//        [str appendString:@"第一次"];
//        [str replaceCharactersInRange:range withString:@"刘先生"];
//        
//        NSLog(@"%@ hello world!", str);

        Animal *animal = [[Animal alloc] init];
        animal.name = @"老虎";
        animal.age = 12;
        NSLog(@"动物名字:%@",  animal.name);
        NSLog(@"动物年龄:%d",  animal.age);
        [animal run];

        Dog *dog = [[Dog alloc] init];
        dog.name = @"狗";
        NSLog(@"动物名字:%@", dog.name);
        [dog run];
        Animal *animal1 = [[Dog alloc] init];
        [animal1 run];
        
        NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"第一个",@"第二个",@"第三个", nil];
        for(id obj in array)
        {
            NSLog(@"%@", obj);
        }
//        NSEnumerator * enu = [array objectEnumerator];
//        id obj = nil;
//        while(obj = [enu nextObject])
//        {
//            NSLog(@"%@",obj);
//            
//        }
//        NSLog(@"%@", array);
        
        NSNumber *num = [[NSNumber alloc] initWithInt:3];
        NSLog(@"%@", num);
        NSValue *val = [[NSValue alloc] initWithBytes:&person objCType:@encode(struct Person)];
        struct Person per;
        [val getValue:&per];
        NSLog(@"%@,%d",[[NSString alloc] initWithCString:per.name encoding:NSUTF8StringEncoding],per.age);
        
        NSString *str2 = @"报文头|字符串1|字符串2|结束";
        
        NSData *data = [str2 dataUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"第一个", @"1", @"第二个", @"2", @"第三个", @"3", nil];

        NSEnumerator *enum1 = [dict keyEnumerator];
        id key;
        while(key = [enum1 nextObject])
        {
            NSLog(@"键:%@", key);
            NSLog(@"%@",[dict objectForKey:key]);
        }
        NSMutableSet *set = [[NSMutableSet alloc] initWithObjects:@"NO.1", @"NO.2", @"NO.3", nil];

        for(id obj1 in set)
        {
            NSLog(@"%@", obj1);
        }
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(1, 2)];
        [array removeObjectsAtIndexes:indexSet];
        for(id obj in array)
        {
            NSLog(@"%@", obj);
        }
        Singleton *singleton = [Singleton sharedInstance];
        Singleton *singleton1 = [Singleton sharedInstance];
        singleton.name = @"李四";
        NSLog(@"单例:%@",singleton.name);
        NSLog(@"单例1:%@",singleton1.name);
        
//        Send *send = [[Send alloc] init];
//        send.name = @"通知";
//        send.info = dict;
//        [send sendNoticeLoop];
//        
//        Get *get = [[Get alloc] init];
//        get.name = @"通知";
//        [get getNotice];
//        
//        [[NSRunLoop currentRunLoop] run];
        Wife *wife = [[Wife alloc] init];
        Husband *husband = [[Husband alloc] init];
        husband.wife = wife;
        [husband askWifeBuyFood];
        
//        Son *son = [[Son alloc] init];
//        Mother *mom = [[Mother alloc] init];
//        mom.son = son;
//        mom.keyPath = @"age";
//        [mom registerObserver];
//        [[NSRunLoop currentRunLoop] run];
       
        NSMutableArray *tmpArr = [[NSMutableArray alloc] init];
        for(int i = 0; i < 10; i++)
        {
            Item *item = [[Item alloc] init];
            [item setValue:[[NSNumber alloc] initWithInt:i] forKey:@"itemID"];
//            item.itemID = i;
            [item setValue:[[NSString alloc] initWithFormat:@"名字%d", i] forKey:@"itemName"];
//            item.itemName = [[NSString alloc] initWithFormat:@"名字%d", i];
            [item setValue:[[NSNumber alloc] initWithFloat:(100.0f+i)] forKey:@"score"];
//            item.score = 100.0f+i;
            [item setValue:[[NSString alloc] initWithFormat:@"名字%d ID%d 分数%@", i, i, [[NSNumber alloc] initWithFloat:(100.0f+i)]] forKey:@"itemDesc"];
            [tmpArr addObject:item];
        }
        List *list = [[List alloc] init];
        list.itemList = tmpArr;
        for(id obj in list.itemList)
        {
            NSLog(@"%@", [obj valueForKey:@"itemDesc"]);
        }
        
        NSError *err;
//        NSFileManager *fileMgr = [NSFileManager defaultManager];
//        NSArray *fileArr = [fileMgr contentsOfDirectoryAtPath:@PATH error:&err];
//        NSArray *fileArr1 = [fileMgr subpathsOfDirectoryAtPath:@PATH error:&err];
//        [fileMgr createDirectoryAtPath:[NSString stringWithFormat:@"%@/xinjian/xiaoli", @PATH] withIntermediateDirectories:YES attributes:nil error:&err];
//        [fileMgr createFileAtPath:[NSString stringWithFormat:@"%@/xiaoyu", @PATH] contents:data attributes:nil];
//        [fileMgr copyItemAtPath:[NSString stringWithFormat:@"%@/music", @PATH] toPath:[NSString stringWithFormat:@"%@/music2", @PATH] error:&err];
//        [fileMgr moveItemAtPath:[NSString stringWithFormat:@"%@/xiaoyu", @PATH] toPath:[NSString stringWithFormat:@"%@/xinjian/xiaoyu", @PATH] error:&err];
//        [fileMgr removeItemAtPath:[NSString stringWithFormat:@"%@/xiaoyu", @PATH] error:&err];
//        NSLog(@"%@", fileArr1);
//        NSFileHandle *fileHandle4R = [NSFileHandle fileHandleForReadingAtPath:[NSString stringWithFormat:@"%@/xiaoyu", @PATH]];
//        NSData *fileDat = [fileHandle4R readDataToEndOfFile];
//        [fileHandle4R seekToFileOffset:3];
//        NSData *fileDat = [fileHandle4R readDataOfLength:13];
//        NSLog(@"%@", [[NSString alloc] initWithData:fileDat encoding:NSUTF8StringEncoding]);
//        NSFileHandle *fileHnadle4W = [NSFileHandle fileHandleForWritingAtPath:[NSString stringWithFormat:@"%@/xiaoyu", @PATH]];
//        [fileHnadle4W truncateFileAtOffset:13];
//        [fileHnadle4W truncateFileAtOffset:0];
//        [fileHnadle4W writeData:data];
        
        
//        [dict writeToFile:[NSString stringWithFormat:@"%@/xiaoyu.plist", @PATH] atomically:YES];
//        NSMutableData *arcDat = [[NSMutableData alloc] init];
//        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:arcDat];
//        [archiver encodeObject:dict forKey:@"dict"];
//        [archiver finishEncoding];
//        [arcDat writeToFile:[NSString stringWithFormat:@"%@/xiaoyu.plist", @PATH] atomically:YES];
//        
//        NSData *unarcDat = [[NSData alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/xiaoyu.plist", @PATH]];
//        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:unarcDat];
//        NSDictionary *dict1 = [unarchiver decodeObjectForKey:@"dict"];
//        NSLog(@"%@",dict1);
        
        
        Human *hu = [[Human alloc] init];
        hu.age = 20;
        hu.name = @"人类";
        NSData *arcDat = [NSKeyedArchiver archivedDataWithRootObject:hu];
        [arcDat writeToFile:[NSString stringWithFormat:@"%@/xiaoyu", @PATH] atomically:YES];
        
        NSData *unarcDat = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/xiaoyu", @PATH]];
        Human *hu1 = [NSKeyedUnarchiver unarchiveObjectWithData:unarcDat];
        NSLog(@"年龄:%d 名%lu%@", hu1.age,(unsigned long) hu1.name);
        
        if(err)
        {
            NSLog(@"%@", err);
        }
        
        
        
        
        
        
        
        
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
