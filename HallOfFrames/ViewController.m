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
#import "MyCustomView.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,MyCustomViewDelegate>

@property NSArray* pictures;
@property PictureCollectionViewCell* currentSelectedCell;
@property NSInteger selectedCellIndex;
@property BOOL menuShown;
@property MyCustomView* menuView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    Picture* picture1 = [[Picture alloc]init];
    picture1.image = [UIImage imageNamed:@"DukeAtNight"];
    picture1.frameColor = [self generateRandomColor];
    Picture* picture2 = [[Picture alloc]init];
    picture2.image = [UIImage imageNamed:@"FrenchBridge"];
    picture2.frameColor = [self generateRandomColor];
    Picture* picture3 = [[Picture alloc]init];
    picture3.image = [UIImage imageNamed:@"Painting"];
    picture3.frameColor = [self generateRandomColor];
    Picture* picture4 = [[Picture alloc]init];
    picture4.image = [UIImage imageNamed:@"yosemite"];
    picture4.frameColor = [self generateRandomColor];
    self.pictures = [NSArray arrayWithObjects:picture1,picture2,picture3,picture4,nil];

    // Do any additional setup after loading the view.
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   // Show the new view with options to change color.
    if (!self.menuShown){
        NSArray* newViews = [[NSBundle mainBundle] loadNibNamed:@"CustomizedView" owner:self options:nil];
        MyCustomView* newView = [newViews objectAtIndex:0];
        //Create frame for slider menu
        int x = self.view.frame.origin.x + self.view.frame.size.width * (1.0/5);
        int y = self.view.frame.origin.y + self.view.frame.size.height / 3.0;
        int width = self.view.frame.size.width * (3.0/5);
        int height = self.view.frame.size.height/3.0;
        [newView setFrame:CGRectMake(x, y, width, height)];
        
        CGFloat red,green,blue,alpha;
        Picture* selectedPicture = self.pictures[indexPath.row];
        UIColor *selectedCellFrameColor = selectedPicture.frameColor;
        [selectedCellFrameColor getRed:&red green:&green blue:&blue alpha:&alpha];
        newView.redSlider.value = red;
        newView.greenSlider.value = green;
        newView.blueSlider.value = blue;
        
        newView.delegate = self;
        self.currentSelectedCell = [collectionView cellForItemAtIndexPath:indexPath];
        self.selectedCellIndex = indexPath.row;
        self.menuView = newView;
        [self.view addSubview:self.menuView];
        self.menuShown = true;
    }
    else{
        [self.menuView removeFromSuperview];
        self.menuShown = false;
        self.currentSelectedCell = nil;
        self.selectedCellIndex = -1;
    }
}

-(void)updateColorValueWithRestorationID:(NSString *)color toFloat:(float)newValue{
    UIColor* currentColor = self.currentSelectedCell.backgroundColor;
    CGFloat red,green,blue,alpha;
    [currentColor getRed:&red green:&green blue:&blue alpha:&alpha];
    
    if ([color isEqualToString:@"RedSlider"])
        self.currentSelectedCell.backgroundColor = [UIColor colorWithRed:newValue green:green blue:blue alpha:alpha];
    else if([color isEqualToString:@"GreenSlider"])
        self.currentSelectedCell.backgroundColor = [UIColor colorWithRed:red green:newValue blue:blue alpha:alpha];
    else
        self.currentSelectedCell.backgroundColor = [UIColor colorWithRed:red green:green blue:newValue alpha:alpha];
    
    Picture* changed = [self.pictures objectAtIndex:self.selectedCellIndex];
    changed.frameColor = self.currentSelectedCell.backgroundColor;
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
