//
//  ViewController.m
//  HallOfFrames
//
//  Created by Andrew Bihl on 6/2/16.
//  Copyright © 2016 Andrew Bihl. All rights reserved.
//

#import "ViewController.h"
#import "Picture.h"
#import "PictureCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property NSArray* pictures;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Picture* picture1 = [[Picture alloc]init];
    picture1.image = [UIImage imageNamed:@"DukeAtNight"];
    picture1.frameColor = [self generateRandomColor];
    self.pictures = [NSArray arrayWithObjects:picture1, nil];
    // Do any additional setup after loading the view.
}

-(UIColor*)generateRandomColor{
    float r = (float)arc4random()/INT_MAX;
    float g = (float)arc4random()/INT_MAX;
    float b = (float)arc4random()/INT_MAX;
    UIColor* result = [UIColor colorWithRed:r green:g blue:b alpha:1];
    return result;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PictureCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PictureCell" forIndexPath:indexPath];
    Picture* currentPicture = [self.pictures objectAtIndex:indexPath.row];
    cell.imageView.image = currentPicture.image;
    cell.backgroundColor = currentPicture.frameColor;
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.pictures.count;
}

@end
