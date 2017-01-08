//
//  NSString+JGExtension.m
//  EFFICIENCYLOG
//
//  Created by stkcctv on 16/12/2.
//  Copyright © 2016年 JG. All rights reserved.
//

#import "NSString+JGExtension.h"

@implementation NSString (JGExtension)

//字典转json格式字符串：

+ (NSString*)dictionaryToJson:(NSDictionary *)dic {
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/**
 *  获取当前日期
 */
+ (NSString *)getCurrentData {
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    return [dateformatter stringFromDate:[NSDate date]];
}

/**
 *  根据传入字符串
 *
 *  @param str 传入的日期字符串  形如:Oct 8, 2016 5:29:44 PM
 *
 *  @return 返回所需要的日期字符串  形如:10-08 06:26:55
 */
+ (NSString *)getStrFromDate:(NSString *)str {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MMM d,yyyy HH:mm:ss aa"];
    
    //设置时区 这个对时间的处理有时很重要
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSLocale *local = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:local];
    
    NSDate *date = [formatter dateFromString:str];  //2016-10-08 10:26:55 +0000
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    dateFormatter.dateFormat=@"yyyy-MM-dd hh:mm:ss";//指定转date得日期格式化形式
    NSString *str1 = [dateFormatter stringFromDate:date];
    
//    JGLog(@"转换后： %@",str1);
    
    return [str1 substringWithRange:NSMakeRange(0, 11)];
}


/**
 *  根据模型数据将日志分类， 将 未完成 和 已完成 进行特殊标记，将 已完成 和 未完成 日志等级按重要性又进行了排序
 *
 *  @param arrM 传入的模型数数组
 *
 *  @return 返回整理好的字符串
 */
+ (NSMutableAttributedString *)getAttributedStrFromArr:(NSArray *)arrM {
    
    NSMutableAttributedString *ss;
    return ss;
}




@end
