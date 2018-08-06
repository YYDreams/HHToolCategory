//
//  UIButton+HHPositionStyleButton.m
//  SingleSelOrMultiSel
//
//  Created by flowerflower on 2018/3/26.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "UIButton+HHPositionStyleButton.h"

@implementation UIButton (HHPositionStyleButton)



- (void)hh_imagePositionStyle:(ImagePositionStyle)positionStyle margin:(CGFloat)margin{
    
    
    switch (positionStyle) {
        case ImagePositionStyleDefault:{
            
            if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) {
                
                self.titleEdgeInsets = UIEdgeInsetsMake(0, margin, 0, 0);
                
            }else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight){
                self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, margin);
                
            }else{
                self.imageEdgeInsets = UIEdgeInsetsMake(0 , - 0.5 * margin, 0, 0.5 * margin);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, 0.5 * margin, 0, - 0.5 * margin);

            }
        }
            break;
        case ImagePositionStyleRight:{
            CGFloat imageW = self.imageView.image.size.width;
            CGFloat titleW = self.titleLabel.frame.size.width;
            if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) {
                self.imageEdgeInsets = UIEdgeInsetsMake(0, titleW + margin, 0, 0);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageW, 0, 0);
            } else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight) {
                self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, - titleW);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, imageW + margin);
            } else {
                CGFloat imageOffset = titleW + 0.5 * margin;
                CGFloat titleOffset = imageW + 0.5 * margin;
                self.imageEdgeInsets = UIEdgeInsetsMake(0, imageOffset, 0, - imageOffset);
                self.titleEdgeInsets = UIEdgeInsetsMake(0, - titleOffset, 0, titleOffset);
            }
            
        }
            break;
        case ImagePositionStyleTop:{
            CGFloat imageW = self.imageView.frame.size.width;
            CGFloat imageH = self.imageView.frame.size.height;
            CGFloat titleIntrinsicContentSizeW = self.titleLabel.intrinsicContentSize.width;
            CGFloat titleIntrinsicContentSizeH = self.titleLabel.intrinsicContentSize.height;
            self.imageEdgeInsets = UIEdgeInsetsMake(- titleIntrinsicContentSizeH - margin, 0, 0, - titleIntrinsicContentSizeW);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageH, - imageH - margin, 0);
            
        }
            break;
        case ImagePositionStyleBottom:{
            CGFloat imageW = self.imageView.frame.size.width;
            CGFloat imageH = self.imageView.frame.size.height;
            CGFloat titleIntrinsicContentSizeW = self.titleLabel.intrinsicContentSize.width;
            CGFloat titleIntrinsicContentSizeH = self.titleLabel.intrinsicContentSize.height;
            self.imageEdgeInsets = UIEdgeInsetsMake(titleIntrinsicContentSizeH + margin, 0, 0, - titleIntrinsicContentSizeW);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageW, imageH + margin, 0);
        }
            break;
            
        default:
            break;
    }
    
    
    
    
}



@end
