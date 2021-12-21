//
//  UIView+Tap.m
//  useARFramework
//
//  Created by ply on 21/12/20.
//  Copyright © ABC. All rights reserved.
//

#import "UIView+Tap.h"
#import <objc/message.h>

@implementation UIView (Tap)

static char touchKey;

- (void)tapHandle:(void(^)())tapBlock {

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    
    self.userInteractionEnabled = YES;
    
    [self addGestureRecognizer:tapGesture];
    objc_setAssociatedObject(self, &touchKey, tapBlock,OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    void (^block)() = objc_getAssociatedObject(self, &touchKey);
    
    if (block) block();
    
}

@end
