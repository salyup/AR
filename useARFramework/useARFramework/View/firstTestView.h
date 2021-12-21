//
//  firstTestView.h
//  useARFramework
//
//  Created by CrabMan on 16/5/18.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^MyBlock)();

@interface firstTestView : UIView

@property (nonatomic,strong) MyBlock block;

@end
