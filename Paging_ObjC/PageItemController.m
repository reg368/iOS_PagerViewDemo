//
//  PageItemController.m
//  HandOff_ObjC
//
//  Created by Olga Dalton on 23/10/14.
//  Copyright (c) 2014 Olga Dalton. All rights reserved.
//

#import "PageItemController.h"

@interface PageItemController ()

@end

@implementation PageItemController


#pragma mark -
#pragma mark Override get method (init property )

-(id)initWithImageFrame:(CGRect)frame andImageName:(NSString*)imageName andItemIndex:(NSInteger)itemIndex {
    if(self = [super init]){
        _imageFrame = frame;
        _imageName = imageName;
        _itemIndex = itemIndex;
    }
    return self;
}

-(UIImageView*)contentImageView{
    if(!_contentImageView){
        _contentImageView = [[UIImageView alloc] initWithFrame:_imageFrame];
         [self.view addSubview:self.contentImageView];
        UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick:)];
        [singleTap setNumberOfTapsRequired:1];
        [_contentImageView setUserInteractionEnabled:YES];
        [_contentImageView addGestureRecognizer:singleTap];
        
    }
    return _contentImageView;
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentImageView.image = [UIImage imageNamed: _imageName];
}

#pragma mark -
#pragma mark View action method
-(void)viewClick:(UIGestureRecognizer *)recognizer{
    NSLog(@"imageName : %@",_imageName);
}

@end
