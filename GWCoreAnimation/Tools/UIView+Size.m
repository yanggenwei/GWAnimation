//
//  UIView+Size.m
//  Pangmaobao
//
//  Created by 杨根威 on 2017/9/25.
//  Copyright © 2017年 Shanghai Birkin Network Technology Co. All rights reserved.
//

#import "UIView+Size.h"

@implementation UIView (Size)

- (CGFloat)height{
    return self.frame.size.height;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

@end
