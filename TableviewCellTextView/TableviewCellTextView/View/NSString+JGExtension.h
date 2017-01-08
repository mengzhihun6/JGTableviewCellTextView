//
//  NSString+JGExtension.h
//  EFFICIENCYLOG
//
//  Created by stkcctv on 16/12/2.
//  Copyright © 2016年 JG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JGExtension)

//字典转json格式字符串：
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

//获取当前日期
+ (NSString *)getCurrentData;

/**
 *  根据传入字符串
 *
 *  @param str 传入的日期字符串  形如:Oct 8, 2016 5:29:44 PM
 *
 *  @return 返回所需要的日期字符串
 */
+ (NSString *)getStrFromDate:(NSString *)str;


/**
 *  根据模型数据将日志分类， 将 未完成 和 已完成 进行特殊标记，将 已完成 和 未完成 日志等级按重要性又进行了排序
 *
 *  @param arrM 传入的模型数数组
 *
 *  @return 返回整理好的字符串
 */
+ (NSMutableAttributedString *)getAttributedStrFromArr:(NSArray *)arrM;


@end
