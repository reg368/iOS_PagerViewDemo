//
//  PageItemController.h
//  HandOff_ObjC
//
//  Created by Olga Dalton on 23/10/14.
//  Copyright (c) 2014 Olga Dalton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageItemController : UIViewController

// Item controller information
@property  (nonatomic) NSUInteger itemIndex;
@property  (nonatomic,strong) NSString *imageName;
@property  (nonatomic,strong) UIImageView *contentImageView;
@property  (nonatomic) CGRect imageFrame;

-(id)initWithImageFrame:(CGRect)frame andImageName:(NSString*)imageName andItemIndex:(NSInteger)itemIndex ;

@end
