//
//  KKRadioButtonGroup.m
//  Rovler
//
//  Created by KEMAL KOCABIYIK on 5/21/12.
//  Copyright (c) 2012 Koc University. All rights reserved.
//

#import "KKRadioButtonGroup.h"
#import "KKRadioButtonPrefs.h"

@interface KKRadioButtonGroup()

-(void) initialize;

@end

@implementation KKRadioButtonGroup

@synthesize items = _items;
@synthesize selectionType = _selectionType;

-(void) setTextLeftPadding:(double)textLeftPadding{
    
    if(textLeftPadding < 30)
        _textLeftPadding = 30;
    else
        _textLeftPadding = textLeftPadding;

    [self refreshLayout];
}

-(void)setButtonTopPadding:(double)buttonTopPadding{
    
    
    if(buttonTopPadding < 30)
        _buttonTopPadding = 30;
    else
        _buttonTopPadding = buttonTopPadding;
    
    [self refreshLayout];
    
}



-(void) setFont:(UIFont *)font {
    
    if(font == nil){
        
        _font = [UIFont fontWithName:@"Helvetica" size:14];
   
    }else{
       
        _font = font;
    }
    
    [self refreshLayout];
}
-(void) setExtraSpace:(double)extraSpace{
    
    _extraSpace = extraSpace;
    
    [self refreshLayout];
}

-(void) setSelectedImage:(UIImage *)selectedImage{
    
    _selectedImage = selectedImage;
    
    for(KKRadioButton *btn in _radioButtons){
        
        [btn.btn_selection setImage:_selectedImage forState:UIControlStateHighlighted];
        [btn.btn_selection setImage:_selectedImage forState:UIControlStateSelected];
    }
}

-(void)setUnSelectedImage:(UIImage *)unSelectedImage{
    
    _unSelectedImage = unSelectedImage;
    
    for(KKRadioButton *btn in _radioButtons){
        
        [btn.btn_selection setImage:_unSelectedImage forState:UIControlStateNormal];
    }
}

-(void)setSelectedIndexes:(NSMutableArray *)selectedIndexes{
    
    
    _selectedIndexes = selectedIndexes;
    
    NSMutableArray *ar = [[NSMutableArray alloc] initWithArray:selectedIndexes];
    id tempDelegate = self.del;
    
    self.del = nil;
    for(NSNumber *number in ar){
        
        if ([number intValue] < self.items.count) {
            
            KKRadioButton *radioButton = (KKRadioButton *) [_radioButtons objectAtIndex:[number intValue]];
            
            if(radioButton != NULL){
                [radioButton select];
            }
            
            
        }
    }
    self.del = tempDelegate;
}

-(id)initWithFrame:(CGRect)frame items:(NSArray *) textItems selectionType:(RadioButtonSelectionType) t {
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        _textLeftPadding = 30;
        
        _buttonTopPadding = 30;
        
        isInitializationDone = NO;
        
        _selectedIndexes = [[NSMutableArray alloc] init];
        
        _items = [[NSMutableArray alloc] initWithArray:textItems];
        
        _radioButtons = [[NSMutableArray alloc] init];
        
        
        _selectionType = t;
        
        self.backgroundColor = [UIColor clearColor];
        
        [self refreshLayout];
    }
    
    return self;
}


-(id)initWithFrame:(CGRect)frame items:(NSArray *) textItems selectionType:(RadioButtonSelectionType) t
   selectedIndexes:(NSMutableArray *) ar{
    
    assert(ar != nil);
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        isInitializationDone = NO;
        
        _items = [[NSMutableArray alloc] initWithArray:textItems];
        
        _radioButtons = [[NSMutableArray alloc] init];
        
        _selectionType = t;
        
        self.backgroundColor = [UIColor clearColor];
        
        [self refreshLayout];
        
        self.selectedIndexes = ar;
    }
    
    return self;
}

-(void) initialize{
    
    if(_radioButtons != nil){
        
        [_radioButtons removeAllObjects];
        
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        
    }else{
        
        _radioButtons = [[NSMutableArray alloc] init];
    }
    
    if(self.items != nil){
        
        for(NSString *dict in self.items){
            
            NSString *str = dict;
            
            KKRadioButton *radioButton = [[KKRadioButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) text:str selectionType:self.selectionType textLeftPadding:self.textLeftPadding buttonTopPadding:self.buttonTopPadding  andFont:self.font];
            
            radioButton.delegate = self;
            
            [_radioButtons addObject:radioButton];
            
            [self addSubview:radioButton];
            
        }
        
    }
    
    if(self.selectedIndexes == nil){
        
        _selectedIndexes = [[NSMutableArray alloc] init];
    }
    
    isInitializationDone = YES;
}

/* Refreshes ayout */
-(void) refreshLayout{
    
    [self initialize];
    
    float height = 0;
    for(int i = 0 ; i < _radioButtons.count ; i++){
        
        KKRadioButton *radioButton = [_radioButtons objectAtIndex:i];
        
        if(i != 0)
            radioButton.frame = CGRectMake(radioButton.frame.origin.x, height+self.extraSpace, radioButton.frame.size.width, radioButton.frame.size.height);
        
        height = radioButton.frame.size.height + radioButton.frame.origin.y;
    }
    
    [self setSelectedImage:self.selectedImage];
    [self setUnSelectedImage:self.unSelectedImage];
    
    if(self.frame.size.height < height){
        
        [self setContentSize:CGSizeMake(self.frame.size.width, height)];
        
        [self setScrollEnabled:YES];
    }else{
        
        [self setScrollEnabled:NO];
    }
}

#pragma mark - KKRadioButtonDelegate

-(void)radioButtonDidSelect:(KKRadioButton *)radioButton{
    
    int counter = 0;
    if(isInitializationDone){
        
        if(self.selectionType == kSingleChoice){
            
            for(KKRadioButton *rb in _radioButtons){
                
                if(rb == radioButton){
                    
                    if(self.del != nil)
                        [self.del radioButtonGroup:self selectedIndex:counter];
                    
                }else{
                    
                    [rb deSelect];
                }
                
                counter ++;
                
            }
            
        }else{
        
            [self arrangeAndNotifyForSelectedIndexes];
        }
    }
}

-(void)radioButtonDidDeSelect:(KKRadioButton *)radioButton{
    
   
    if(isInitializationDone){
        
        if (self.selectionType == kMultipleChoice) {
            
            [self arrangeAndNotifyForSelectedIndexes];
        }
    }
}

-(void) arrangeAndNotifyForSelectedIndexes{
     int counter = 0;
    
    [self.selectedIndexes removeAllObjects];
    
    for(KKRadioButton *rb in _radioButtons){
        
        if(rb.selected == YES){
            
            [self.selectedIndexes addObject:[NSNumber numberWithInt:counter]];
            
        }
        
        counter ++;
    }
    
    if(self.del != nil){
        
        [self.del radioButtonGroup:self selectedIndexes:self.selectedIndexes];
    }

}



@end
