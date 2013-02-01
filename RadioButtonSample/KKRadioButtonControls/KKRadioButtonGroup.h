//
//  KKRadioButtonGroup.h
//  Rovler
//
//  Created by KEMAL KOCABIYIK on 5/21/12.
//  Copyright (c) 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKRadioButton.h"

@class KKRadioButtonGroup;


/*RADIO BUTTON GROUP DELEGATES THESE ARE THE ACTUAL DELEGATES THAT YOU ARE GOING TO USE IN VIEW CONTROLLER*/
@protocol KKRadioButtonGroupDelegate <NSObject>

@optional
-(void) radioButtonGroup:(KKRadioButtonGroup *) radioButtonGroup selectedIndexes:(NSArray *) indexes;
-(void) radioButtonGroup:(KKRadioButtonGroup *) radioButtonGroup selectedIndex:(int) index;


@end
@interface KKRadioButtonGroup : UIScrollView <KKRadioButtonDelegate>{
    
    bool isInitializationDone;
    /*Radio buttons that group contains are stored.*/
    NSMutableArray *_radioButtons;
    
}


/*STRINGS THAT IS GOING TO BE PRESENT*/
@property (nonatomic , strong) NSMutableArray *items;

/*SELECTED INDEXES. IT CONTAINS NSNUMBER OBJECTS AS INDEXES.*/
@property (nonatomic , strong) NSMutableArray *selectedIndexes;

/*THE TYPE OF SELECTION: MULTIPLECHOICE OR SINGLECHOICE */
@property (nonatomic) RadioButtonSelectionType selectionType;

/*BUTTON IMAGE*/
@property (nonatomic , strong) UIImage *selectedImage;

/*BUTTON IMAGE*/
@property (nonatomic , strong) UIImage *unSelectedImage;

/*EXTRA SPACE BETWEEN CHOICES*/
@property (nonatomic) double extraSpace;

/*CHOICE FONT*/
@property (nonatomic , strong) UIFont *font;

/*TEXT PADDING*/
@property (nonatomic) double textLeftPadding;

/*BUTTON TOP PADDING*/
@property (nonatomic) double buttonTopPadding;

/*DELEGATE*/
@property (nonatomic , weak) id<KKRadioButtonGroupDelegate> del;

-(id)initWithFrame:(CGRect)frame items:(NSArray *) textItems selectionType:(RadioButtonSelectionType) t;

-(id)initWithFrame:(CGRect)frame items:(NSArray *) textItems selectionType:(RadioButtonSelectionType) t selectedIndexes:(NSMutableArray *) ar;

/*REFRESHES THE LAYOUT*/
-(void) refreshLayout;

@end
