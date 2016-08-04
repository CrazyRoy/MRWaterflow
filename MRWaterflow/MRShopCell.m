//
//  MRShopCell.m
//  MRWaterflow
//
//  Created by Andrew554 on 16/8/4.
//  Copyright © 2016年 Andrew554. All rights reserved.
//

#import "MRShopCell.h"
#import "MRShop.h"
#import "UIImageView+WebCache.h"

@interface MRShopCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end

@implementation MRShopCell

- (void)setShop:(MRShop *)shop
{
    _shop = shop;
    
    // 1.图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    
    // 2.价格
    self.priceLabel.text = shop.price;
}
@end
