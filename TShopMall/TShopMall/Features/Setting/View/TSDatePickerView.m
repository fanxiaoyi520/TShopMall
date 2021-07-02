//
//  TSDatePickerView.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/17.
//

#import "TSDatePickerView.h"

//#define MAXYEAR 2099
#define MINYEAR 1900

@interface TSDatePickerView ()<UIPickerViewDelegate>
{
    //记录位置
    NSInteger yearIndex;
    NSInteger monthIndex;
    NSInteger dayIndex;
    NSDate *_startDate;
    NSInteger preRow;
    NSInteger _maxYear;
    NSInteger _maxMonth;
    NSInteger _maxDay;
}
/** 背景视图 */
@property(nonatomic, weak) UIView *contentView;
/** 顶部视图 */
@property(nonatomic, weak) UIView *topView;
/** 确定 */
@property(nonatomic, weak) UIButton *confirmButton;
/** 取消 */
@property(nonatomic, weak) UIButton *cancelButton;
/** 选择器 */
@property(nonatomic, weak) UIPickerView *pickerView;

@property (strong, nonatomic) NSMutableArray *dayArray;

@property (strong, nonatomic) NSMutableArray *yearArray;

@property (strong, nonatomic) NSMutableArray *monthArray;

@property (nonatomic, retain) NSDate *scrollToDate;//滚到指定日期
/**
 *  限制最大时间（默认2099）datePicker大于最大日期则滚动回最大限制日期
 */
@property (nonatomic, retain) NSDate *maxLimitDate;
/**
 *  限制最小时间（默认0） datePicker小于最小日期则滚动回最小限制日期
 */
@property (nonatomic, retain) NSDate *minLimitDate;

@end

@implementation TSDatePickerView

- (instancetype)init {
    if (self = [super init]) {
        [self setUpInit];
    }
    return self;
}

+ (instancetype)datePickerView {
    return [[self alloc] init];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:.5 animations:^{
        CGRect rect = self.contentView.frame;
        rect.origin.y = kScreenHeight - self.contentView.frame.size.height;
        self.contentView.frame = rect;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:.5 animations:^{
        CGRect rect = self.contentView.frame;
        rect.origin.y += self.contentView.bounds.size.height;
        self.contentView.frame = rect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)setUpInit {
    [self customSelectedRow];
    self.contentView.backgroundColor = KWhiteColor;
    self.frame = [[UIScreen mainScreen] bounds];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.contentView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 178 + GK_SAFEAREA_BTM);
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.height.mas_equalTo(45);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left).with.offset(16);
        make.top.equalTo(self.topView.mas_top).with.offset(16);
    }];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topView.mas_right).with.offset(-16);
        make.top.equalTo(self.topView.mas_top).with.offset(16);
    }];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(16);
        make.right.equalTo(self.contentView.mas_right).with.offset(-16);
        make.top.equalTo(self.topView.mas_bottom).with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-GK_SAFEAREA_BTM);
    }];
    [self initData];
}

- (void)initData {
    self.dayArray = [NSMutableArray array];
    self.yearArray = [NSMutableArray array];
    self.monthArray = [NSMutableArray array];
    
    NSDate *currentDate = [NSDate date];
    
    _maxYear = [[currentDate stringWithFormat:@"yyyy"] integerValue];
    
    _maxMonth = [[currentDate stringWithFormat:@"MM"] integerValue];
    
    _maxDay = [[currentDate stringWithFormat:@"dd"] integerValue];
    
    for (int i = 1; i < 32; i++) {
        NSString *num = [NSString stringWithFormat:@"%02d", i];
        if (i <= 12) {
            [_monthArray addObject:num];
        }
    }
    for (NSInteger i = MINYEAR; i <= _maxYear; i++) {
        NSString *num = [NSString stringWithFormat:@"%ld",(long)i];
        [_yearArray addObject:num];
    }
    
    //最大最小限制
    if (!self.maxLimitDate) {
        self.maxLimitDate = [NSDate dateWithString:[currentDate stringWithFormat:@"yyyy-MM-dd"] format:@"yyyy-MM-dd"];
    }
    //最小限制
    if (!self.minLimitDate) {
        self.minLimitDate = [NSDate dateWithString:@"1900-01-01" format:@"yyyy-MM-dd"];
    }
    if (self.startDateString == nil) {
        self.startDateString = @"1990-06-15";
    }
    self.scrollToDate = [NSDate dateWithString:self.startDateString format:@"yyyy-MM-dd"];
    _startDate = self.scrollToDate;
    [self getNowDate: self.scrollToDate animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.contentView];
    if (CGRectContainsPoint(self.contentView.frame, point)) {
        return;
    }
    [self dismiss];
}

- (UIView *)contentView {
    if (_contentView == nil) {
        UIView *contentView = [[UIView alloc] init];
        _contentView = contentView;
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (UIView *)topView {
    if (_topView == nil) {
        UIView *topView = [[UIView alloc] init];
        _topView = topView;
        [self.contentView addSubview:_topView];
    }
    return _topView;
}

- (UIButton *)cancelButton {
    if (_cancelButton == nil) {
        UIButton *cancelButton = [[UIButton alloc] init];
        _cancelButton = cancelButton;
        _cancelButton.titleLabel.font = KRegularFont(16);
        [_cancelButton setTitleColor:KHexColor(@"#FF4D49") forState:(UIControlStateNormal)];
        [_cancelButton setTitle:@"取消" forState:(UIControlStateNormal)];
        [_cancelButton addTarget:self action:@selector(cancelAciton) forControlEvents:(UIControlEventTouchUpInside)];
        [self.topView addSubview:_cancelButton];
    }
    return _cancelButton;
}

- (UIButton *)confirmButton {
    if (_confirmButton == nil) {
        UIButton *confirmButton = [[UIButton alloc] init];
        _confirmButton = confirmButton;
        _confirmButton.titleLabel.font = KRegularFont(16);
        [_confirmButton setTitleColor:KHexColor(@"#FF4D49") forState:(UIControlStateNormal)];
        [_confirmButton setTitle:@"确定" forState:(UIControlStateNormal)];
        [_confirmButton addTarget:self action:@selector(confirmAciton) forControlEvents:(UIControlEventTouchUpInside)];
        [self.topView addSubview:_confirmButton];
    }
    return _confirmButton;
}

- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        UIPickerView *pickerView = [[UIPickerView alloc] init];
        _pickerView = pickerView;
        _pickerView.delegate = self;
        _pickerView.showsSelectionIndicator = YES;
        [self.contentView addSubview:_pickerView];
    }
    return _pickerView;
}

- (void)customSelectedRow
{
    NSArray *subviews = self.subviews;
    if (!(subviews.count > 0)) {
        return;
    }
    NSArray *coloms = subviews.firstObject;
    if (coloms) {
        NSArray *subviewCache = [coloms valueForKey:@"subviewCache"];
        if (subviewCache.count > 0) {
            UIView *middleContainerView = [subviewCache.firstObject valueForKey:@"middleContainerView"];
            if (middleContainerView) {
                middleContainerView.layer.cornerRadius = 5;
                middleContainerView.clipsToBounds = YES;
                middleContainerView.backgroundColor = KHexColor(@"#F4F4F5");
            }
        }
    }
}

#pragma mark - Actions
- (void)cancelAciton {
    [self dismiss];
}

- (void)confirmAciton {
    if ([self.delegate respondsToSelector:@selector(selectedDateString:)]) {
        [self.delegate selectedDateString:[self.scrollToDate stringWithFormat:@"yyyy-MM-dd"]];
    }
    [self dismiss];
}

#pragma mark - UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *pickerLabel = (UILabel *)view;
    if (pickerLabel == nil) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        if (component == 0) {
            [pickerLabel setTextAlignment:NSTextAlignmentRight];
        } else if (component == 1) {
            [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        } else if (component == 2) {
            [pickerLabel setTextAlignment:NSTextAlignmentLeft];
        }
        [pickerLabel setFont:KRegularFont(16)];
        [pickerLabel setTextColor:KHexColor(@"#2D3132")];
    }
    NSString *title;
    if (component == 0) {
        title = [_yearArray[row] stringByAppendingString:@"年"];
    }
    if (component == 1) {
        title = [_monthArray[row] stringByAppendingString:@"月"];
    }
    if (component == 2) {
        title = [_dayArray[row] stringByAppendingString:@"日"];
    }
    pickerLabel.text = title;
    return pickerLabel;
}

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *numberArr = [self getNumberOfRowsInComponent];
    return [numberArr[component] integerValue];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        yearIndex = row;
    }
    if (component == 1) {
        monthIndex = row;
    }
    if (component == 2) {
        dayIndex = row;
    }
    if (component == 0 || component == 1){
        [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
        if (_dayArray.count - 1 < dayIndex) {
            dayIndex = _dayArray.count - 1;
        }
    }
    
    [pickerView reloadAllComponents];
    
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@", _yearArray[yearIndex], _monthArray[monthIndex], _dayArray[dayIndex]];
    
    self.scrollToDate = [NSDate dateWithString:dateStr format:@"yyyy-MM-dd"];
    
    if ([self.scrollToDate compare:self.minLimitDate] == NSOrderedAscending) {
        self.scrollToDate = self.minLimitDate;
        [self getNowDate:self.minLimitDate animated:YES];
    } else if ([self.scrollToDate compare:self.maxLimitDate] == NSOrderedDescending){
        self.scrollToDate = self.maxLimitDate;
        [self getNowDate:self.maxLimitDate animated:YES];
    }
    _startDate = self.scrollToDate;
}

#pragma mark - tools

- (NSArray *)getNumberOfRowsInComponent {
    NSInteger yearNum = _yearArray.count;
    NSInteger monthNum = _monthArray.count;
    NSInteger dayNum = 0;
    if (yearIndex + MINYEAR == _maxYear) {
        monthNum = _maxMonth;
        if (_maxMonth == monthIndex + 1) {
            dayNum = _maxDay;
        } else {
            dayNum = [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
        }
    } else {
        dayNum = [self DaysfromYear:[_yearArray[yearIndex] integerValue] andMonth:[_monthArray[monthIndex] integerValue]];
    }
    return @[@(yearNum), @(monthNum), @(dayNum)];
}

//通过年月求每月天数
- (NSInteger)DaysfromYear:(NSInteger)year andMonth:(NSInteger)month
{
    NSInteger num_year  = year;
    NSInteger num_month = month;
    
    BOOL isrunNian = num_year % 4 == 0 ? (num_year % 100 == 0? (num_year % 400 == 0? YES : NO) : YES) : NO;
    switch (num_month) {
        case 1:case 3:case 5:case 7:case 8:case 10:case 12:{
            [self setdayArray:31];
            return 31;
        }
        case 4:case 6:case 9:case 11: {
            [self setdayArray:30];
            return 30;
        }
        case 2:{
            if (isrunNian) {
                [self setdayArray:29];
                return 29;
            }else{
                [self setdayArray:28];
                return 28;
            }
        }
        default:
            break;
    }
    return 0;
}

//滚动到指定的时间位置
- (void)getNowDate:(NSDate *)date animated:(BOOL)animated
{
    if (!date) {
        date = [NSDate date];
    }
    [self DaysfromYear:date.year andMonth:date.month];
    
    yearIndex = date.year - MINYEAR;
    monthIndex = date.month-1;
    dayIndex = date.day-1;
    
    //循环滚动时需要用到
    preRow = (self.scrollToDate.year - MINYEAR) * 12 + self.scrollToDate.month - 1;
    
    NSArray *indexArray = @[@(yearIndex), @(monthIndex), @(dayIndex)];
    
    [self.pickerView reloadAllComponents];
    
    for (int i = 0; i < indexArray.count; i++) {
        
        [self.pickerView selectRow:[indexArray[i] integerValue] inComponent:i animated:animated];
        
    }
}

//设置每月的天数数组
- (void)setdayArray:(NSInteger)num
{
    [_dayArray removeAllObjects];
    for (int i=1; i<=num; i++) {
        [_dayArray addObject:[NSString stringWithFormat:@"%02d",i]];
    }
}

@end

