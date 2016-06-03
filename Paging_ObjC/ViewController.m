//
//  ViewController.m
//  HandOff_ObjC
//
//  Created by Olga Dalton on 23/10/14.
//  Copyright (c) 2014 Olga Dalton. All rights reserved.
//

#import "ViewController.h"
#import "PageItemController.h"
#import "CollectionViewCell.h"

@interface ViewController () <UIPageViewControllerDataSource,UIPageViewControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

@property (nonatomic, strong) NSArray *contentImages;
@property (nonatomic,strong) NSArray *collectionImages;
@property (nonatomic,strong) NSArray *collectionTitle;
@property (nonatomic,strong) UIPageViewController *pageController;
@property (nonatomic, strong) NSMutableArray *pageItems;
@property (nonatomic,strong) UICollectionView *collectionView;
@property int index;

@end

@implementation ViewController
static NSString * const reuseIdentifier = @"Cell";

#pragma mark -
#pragma mark Override get method (init property)

-(NSArray*)contentImages{
    if(!_contentImages){
        _contentImages = @[@"nature_pic_1.png",
                           @"nature_pic_2.png",
                           @"nature_pic_3.png",
                           @"nature_pic_4.png"];
    }
    return _contentImages;
}


-(NSArray*)collectionImages{
    if(!_collectionImages){
        _collectionImages = @[@"indbtna",
                              @"indbtnb",
                              @"indbtnc",
                              @"indbtnd",
                              @"indbtne",
                              @"indbtnf"];
    }
    return _collectionImages;
}

-(NSArray*)collectionTitle{
    if(!_collectionTitle){
        _collectionTitle = @[@"新聞發布",
                              @"法規最新消息",
                              @"所屬機關連結",
                              @"法務部簡介",
                              @"法務部資料庫",
                              @"影音下載"];
    }
    return _collectionTitle;
}



-(NSMutableArray*)pageItems{
    if(!_pageItems){
        _pageItems = [NSMutableArray new];
        if([self.contentImages count]){
            for(int  i = 0 ; i < [self.contentImages count] ; i ++){
                PageItemController *pageItem = [[PageItemController alloc] initWithImageFrame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 2 - 36) andImageName:self.contentImages[i] andItemIndex:i];
                [_pageItems addObject:pageItem];
            }
        }
    }
    return _pageItems;
}

-(UIPageViewController*)pageController{
    if(!_pageController){
        _pageController = [[UIPageViewController alloc]
                           initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                           navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                           options:nil];
        _pageController.delegate = self;
        _pageController.dataSource = self;
        _pageController.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 2);
    }
    return _pageController;
}

-(UICollectionView*)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = self.view.frame.size.height / 12 ; /* 上下間距 */
        layout.minimumInteritemSpacing = self.view.frame.size.width / 25;  /* 左右間距 */
        layout.itemSize = CGSizeMake(self.view.frame.size.width / 4, (self.view.bounds.size.height / 2) / 4.8);
       
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 11 , CGRectGetMaxY(self.pageController.view.frame) + 42, self.view.bounds.size.width / 1.2 ,self.view.bounds.size.height / 2) collectionViewLayout:layout];
        [_collectionView setDataSource:self];
        [_collectionView setDelegate:self];
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
    }
    return _collectionView;
}

#pragma mark -
#pragma mark View Lifecycle

- (void) viewDidLoad
{
    [super viewDidLoad];
    _index = 0;
    [self createPageViewController];
    [self setupPageControl];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(loadNextController)
                                   userInfo:nil
                                    repeats:YES];
    
    [self.view addSubview:self.collectionView];
}

#pragma mark -
#pragma mark Self method

- (void) createPageViewController
{
    [self addChildViewController:self.pageController];
    [self.view addSubview: self.pageController.view];
    [self.pageController didMoveToParentViewController: self];
    
    if([self.contentImages count])
    {
        NSArray *startingViewControllers = @[self.pageItems[0]];
        [self.pageController setViewControllers: startingViewControllers
                                 direction: UIPageViewControllerNavigationDirectionForward
                                  animated: NO
                                completion: nil];
    }

}

- (void) setupPageControl
{
    [[UIPageControl appearance] setPageIndicatorTintColor: [UIColor grayColor]]; /* 剩下尚未顯示的點點顏色 */
    [[UIPageControl appearance] setCurrentPageIndicatorTintColor: [UIColor whiteColor]]; /* 目前顯示的點點顏色 */
    [[UIPageControl appearance] setBackgroundColor: [UIColor clearColor]]; /* 背景色 */
}


- (void)loadNextController {
    
    if(_index+1 > self.pageItems.count - 1){
        _index = 0;
    }else
        _index++;

    PageItemController *pageItem = [self.pageItems objectAtIndex:_index];
    NSArray *startingViewControllers = @[pageItem];
    
    [self.pageController setViewControllers:startingViewControllers
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:YES
                  completion:nil];
    [self  presentationIndexForPageViewController:self.pageController];
}


/*
 - (PageItemController *) itemControllerForIndex: (NSUInteger) itemIndex
 {
 if (itemIndex < self.contentImages.count)
 {
 PageItemController *pageItemController = [[PageItemController alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 2) andImageName:contentImages[itemIndex] andItemIndex:itemIndex];
 return pageItemController;
 }
 
 return nil;
 }
 */

#pragma mark -
#pragma mark UIPageViewControllerDelegate
- (UIViewController *) pageViewController: (UIPageViewController *) pageViewController viewControllerBeforeViewController:(UIViewController *) viewController
{
    PageItemController *itemController = (PageItemController *) viewController;
    if (itemController.itemIndex > 0)
        
    {
        return [self.pageItems objectAtIndex:itemController.itemIndex-1];
    }
    
    
    return nil;
}

- (UIViewController *) pageViewController: (UIPageViewController *) pageViewController viewControllerAfterViewController:(UIViewController *) viewController
{
    PageItemController *itemController = (PageItemController *) viewController;
    
    if (itemController.itemIndex+1 < self.contentImages.count)
    {
        return [self.pageItems objectAtIndex:itemController.itemIndex+1];
    }
    
    return nil;
}


#pragma mark -
#pragma mark UIPageViewControllerDataSource

- (NSInteger) presentationCountForPageViewController: (UIPageViewController *) pageViewController
{
    return self.contentImages.count;
}

- (NSInteger) presentationIndexForPageViewController: (UIPageViewController *) pageViewController
{
    NSArray *vcs = pageViewController.viewControllers;
    PageItemController *viewController =  (PageItemController *)vcs[0];
    return viewController.itemIndex;
}

#pragma mark -
#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionImages.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:self.collectionImages[indexPath.row]];
    cell.title_label.text = self.collectionTitle[indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

/*
#pragma mark -
#pragma mark UICollectionViewDelegateFlowLayout


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width / 3, self.collectionView.frame.size.height / 2);
}
*/

@end
