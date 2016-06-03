//
//  CollectionViewCell.m
//  Paging_ObjC
//
//  Created by t00javateam@gmail.com on 2016/5/17.
//  Copyright © 2016年 Olga Dalton. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

-(UIImageView*)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height - 15)];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        //_imageView.contentMode = UIViewContentModeScaleAspectFill;
        //_imageView.clipsToBounds = YES;
    }
    return _imageView;
}

-(UILabel*)title_label{
    if(!_title_label){
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame)+10, self.contentView.frame.size.width, 10)];
        _title_label.textAlignment = NSTextAlignmentCenter;
        [_title_label setFont:[UIFont systemFontOfSize:13]];
    }
    return _title_label;
}

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        //self.contentView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.title_label];
    }
    return self;
}

@end
