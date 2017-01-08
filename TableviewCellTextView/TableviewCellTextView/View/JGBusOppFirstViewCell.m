//
//  JGBusOppFirstViewCell.m
//  EFFLOG
//
//  Created by stkcctv on 17/1/4.
//  Copyright © 2017年 JG. All rights reserved.
//

#import "JGBusOppFirstViewCell.h"

@implementation JGBusOppFirstViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.contentTextV.autocorrectionType = UITextAutocorrectionTypeNo;
    self.contentTextV.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    // 添加监听器，监听自己的文字改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    
}

- (void)textDidChange {
    
    if (self.JGBusOppFirstViewDelegate != nil && [self.JGBusOppFirstViewDelegate respondsToSelector:@selector(JGBusOppFirstViewTextViewDidChange:andTableViewCell:)]) {
        
        [self.JGBusOppFirstViewDelegate JGBusOppFirstViewTextViewDidChange:self.contentTextV.text andTableViewCell:self];
    }
    
    
}

    
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
