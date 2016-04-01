//
//  MainCollectionViewController.m
//  WebBrowser
//
//  Created by panelsen on 16/3/31.
//  Copyright © 2016年 panelsen. All rights reserved.
//

#import "MainCollectionViewController.h"
#import "CollectionViewCell.h"
#import "ViewController.h"
#import "WebViewController.h"
@interface MainCollectionViewController ()

@end

@implementation MainCollectionViewController

static NSString * const reuseIdentifier = @"CollectionCell";

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapEditAction:(id)sender {
    ViewController *vc = [[UIStoryboard storyboardWithName:@"Main"
                                                                bundle:[NSBundle mainBundle]]
                                      instantiateViewControllerWithIdentifier:@"ViewController"];
    
    [self.navigationController showViewController:vc sender:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.layer.borderWidth  =1;
    cell.layer.borderColor  = [[UIColor redColor] CGColor];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (CGSize)collectionView: (UICollectionView *)collectionView
                  layout: (UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath: (NSIndexPath *)indexPath{
    CGFloat heightOfCell = arc4random() % 100 + 30;
    if (heightOfCell < 30) {
        heightOfCell = 30;
    }
    return CGSizeMake(heightOfCell * 1.4, heightOfCell);
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s, indexPath:%@", __func__, indexPath);
	return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s, indexPath:%@", __func__, indexPath);
    CollectionViewCell *currentHighlightCell = (CollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    [UIView animateWithDuration:0.1 animations:^{
        CGAffineTransform newTransform = CGAffineTransformScale(currentHighlightCell.transform, 2, 2);
        [currentHighlightCell setTransform:newTransform];
    }];
    [[currentHighlightCell superview] bringSubviewToFront:currentHighlightCell];
}
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s, indexPath:%@", __func__, indexPath);
    CollectionViewCell *currentHighlightCell = (CollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:0.1 animations:^{
        CGAffineTransform newTransform = CGAffineTransformIdentity;
        [currentHighlightCell setTransform:newTransform];
    }];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __func__);
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s, indexPath:%@", __func__, indexPath);
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s, indexPath:%@", __func__, indexPath);
    WebViewController *webViewController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    webViewController.currentBaseUrlStr = @"http://www.apple.com";
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
}
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    NSLog(@"%s", __func__);
	return YES;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    NSLog(@"%s", __func__);
}

@end
