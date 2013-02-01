//
//  KKRadioButton.h
//  Rovler
//
//  Created by KEMAL KOCABIYIK on 5/21/12.
//  Copyright (c) 2012. All rights reserved.
//

#import <UIKit/UIKit.h>


/*DEFINES THE TYPE OF RADIO BUTTON*/
typedef enum{
    
    kSingleChoice,
    kMultipleChoice
    
}RadioButtonSelectionType;


@class KKRadioButton;

/*RADIO BUTTON DELEGATE*/
@protocol KKRadioButtonDelegate <NSObject>

@required
-(void) radioButtonDidSelect:(KKRadioButton *)radioButton;
-(void) radioButtonDidDeSelect:(KKRadioButton *)radioButton;

@end

@interface KKRadioButton : UIView{
    RadioButtonSelectionType _selectionType;
}

@property (nonatomic) bool selected;
@property (nonatomic , strong) NSString *text;
@property (nonatomic , strong) UILabel *lbl_text;
@property (nonatomic , strong) UIButton *btn_selection;
@property (nonatomic , strong) UIImage *image;
@property (nonatomic , strong) id<KKRadioButtonDelegate> delegate;


-(id) initWithFrame:(CGRect)frame text:(NSString *) txt selectionType:(RadioButtonSelectionType) sType textLeftPadding:(double) textPadding buttonTopPadding:(double) buttonPadding andFont:(UIFont *) font;

-(void)btn_button_selected:(id)sender;

-(void) deSelect;
-(void) select;

@end
