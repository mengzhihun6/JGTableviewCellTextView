//
//  JGBusOppFirstViewCell.h
//  EFFLOG
//
//  Created by stkcctv on 17/1/4.
//  Copyright © 2017年 JG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JGTextView.h"

@class JGBusOppFirstViewCell;
@protocol JGBusOppFirstViewDelegate <NSObject>

@optional
- (void)JGBusOppFirstViewTextViewDidChange:(NSString *)Str andTableViewCell:(JGBusOppFirstViewCell *)cell;
@end

@interface JGBusOppFirstViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (weak, nonatomic) IBOutlet JGTextView *contentTextV;

/** 代理 */
@property (nonatomic, weak) id <JGBusOppFirstViewDelegate>JGBusOppFirstViewDelegate;
@end
