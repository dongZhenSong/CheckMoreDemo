//
//  TheCollectionTableViewCell.h
//  PullPushDemo
//
//  Created by dongzhensong on 16/9/23.
//  Copyright © 2016年 jinfuma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheCollectionTableViewCell : UITableViewCell

// 用于回调按钮被点击的block
@property (copy, nonatomic) void(^buttonClicked)(NSInteger index);

- (void)setupCellWithNumber:(NSInteger)buttonCount andButtonNameArr:(NSArray *)buttonNameArr;

@end
