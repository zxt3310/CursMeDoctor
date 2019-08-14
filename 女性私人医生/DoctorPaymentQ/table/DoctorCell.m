//
//  DoctorCell.m
//  masonryExample
//
//  Created by zhangxintao on 2019/8/8.
//  Copyright © 2019 zhangxintao. All rights reserved.
//

#import "DoctorCell.h"
#import "Masonry.h"

#define padding 10.0
@interface DoctorCell () <BEMCheckBoxDelegate>
{
    UIImageView *headerImg;
    UILabel *nameLb;
    UILabel *officeLb;
    UILabel *levelLb;
    UILabel *hospitalLb;
    UILabel *skillLb;
    UILabel *priceLb;
    ImageDownloadHelper *imageDownloader;
}
@end
@implementation DoctorCell
@synthesize check = check;
@synthesize doctor = _doctor;

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *containorView = [[UIView alloc] init];
        [self.contentView addSubview:containorView];
        [containorView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.contentView.mas_left).offset(padding);
            make.top.equalTo(self.contentView.mas_top).offset(padding);
            make.right.equalTo(self.contentView.mas_right).offset(-padding);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-padding);
        }];
        
        headerImg = [[UIImageView alloc] init];
        headerImg.backgroundColor = [UIColor lightGrayColor];
        headerImg.layer.cornerRadius = 35;
        headerImg.clipsToBounds = YES;
        [containorView addSubview:headerImg];
        [headerImg mas_makeConstraints:^(MASConstraintMaker *make){
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(70);
            make.left.equalTo(containorView.mas_left).offset(0);
            make.top.equalTo(containorView.mas_top).offset(0);
        }];
        
        UIView *infoView = [[UIView alloc] init];
        [containorView addSubview:infoView];
        [infoView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self->headerImg.mas_right).offset(10);
            make.top.equalTo(self->headerImg.mas_top).offset(0);
            make.right.equalTo(containorView.mas_right).offset(0);
            make.bottom.equalTo(containorView.mas_bottom).offset(0);
        }];
        
        nameLb = [[UILabel alloc] init];
        nameLb.font = [UIFont systemFontOfSize:16];
        nameLb.text = @"张三";
        [infoView addSubview:nameLb];
        
        [nameLb mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(infoView.mas_left).offset(0);
            make.top.equalTo(infoView.mas_top).offset(0);
        }];
        
        officeLb = [[UILabel alloc] init];
        officeLb.font = [UIFont systemFontOfSize:14];
//        officeLb.text = @"泌尿外科";
        [infoView addSubview:officeLb];
        [officeLb mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self->nameLb.mas_right).offset(20);
            make.centerY.equalTo(self->nameLb);
        }];
        
        levelLb = [[UILabel alloc] init];
        levelLb.font = [UIFont systemFontOfSize:14];
        levelLb.text = @"主任医师";
        [infoView addSubview:levelLb];
        
        [levelLb mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self->officeLb.mas_right).offset(20);
            make.centerY.equalTo(self->nameLb);
        }];
        
        hospitalLb = [[UILabel alloc] init];
        hospitalLb.font = [UIFont systemFontOfSize:14];
        hospitalLb.text = @"首都医科大学附属天坛医院";
        [infoView addSubview:hospitalLb];
        
        [hospitalLb mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(infoView.mas_left);
            make.top.equalTo(self->nameLb.mas_bottom).offset(10);
        }];
        
        skillLb = [[UILabel alloc] init];
        skillLb.font = [UIFont systemFontOfSize:14];
        skillLb.numberOfLines = 2;
        skillLb.text = @"擅长：心脑血管疾病，肾衰竭，糖尿病，高血压，冠心病，脑中风，痛风，关节炎";
        [infoView addSubview:skillLb];
        
        [skillLb mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(infoView.mas_left);
            make.right.equalTo(infoView.mas_right).offset(10);
            make.top.equalTo(self->hospitalLb.mas_bottom).offset(10);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor lightGrayColor];
        [infoView addSubview:line];
        
         [line mas_makeConstraints:^(MASConstraintMaker *make){
             make.left.equalTo(infoView.mas_left);
             make.right.equalTo(infoView.mas_right);
             make.top.equalTo(self->skillLb.mas_bottom).offset(10);
             make.height.mas_equalTo(1);
         }];
        
        check = [[BEMCheckBox alloc] init];
        check.onFillColor = [UIColor colorWithRed:28.0/255.0 green:113.0/255.0 blue:61.0/255.0 alpha:1];
        check.onTintColor = [UIColor colorWithRed:28.0/255.0 green:113.0/255.0 blue:61.0/255.0 alpha:1];
        check.onCheckColor = [UIColor whiteColor];
        check.delegate = self;
        check.boxType = BEMBoxTypeSquare;
        check.onAnimationType = BEMAnimationTypeFill;
        check.offAnimationType = BEMAnimationTypeFill;
        [infoView addSubview:check];

        [check mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(infoView.mas_right).offset(-20);
            make.top.equalTo(line.mas_bottom).offset(10);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(20);
        }];

        priceLb = [[UILabel alloc] init];
        priceLb.text = @"￥69.9";
        priceLb.font = [UIFont systemFontOfSize:16];
        priceLb.textColor = [UIColor redColor];
        [infoView addSubview:priceLb];

        [priceLb mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(infoView.mas_left);
            make.centerY.equalTo(self.check);
            make.bottom.equalTo(infoView.mas_bottom).offset(0);
        }];
        
    }
    return self;
}

- (void)setDoctor:(doctorModel *)doctor{
    _doctor = doctor;
    [[self imageDownloader] addImageKey:doctor.pic andSizeType:@"150"];
    [imageDownloader startDownload];
    nameLb.text = doctor.name;
    levelLb.text = doctor.title;
    hospitalLb.text = doctor.hosp_name;
    skillLb.text = doctor.intro;
    priceLb.text = [NSString stringWithFormat:@"￥%0.2f",doctor.price];
    
}

- (ImageDownloadHelper *)imageDownloader
{
    if (!imageDownloader) {
        imageDownloader = [[ImageDownloadHelper alloc] init];
        imageDownloader.delegate = self;
    }
    
    return imageDownloader;
}

- (void)didTapCheckBox:(BEMCheckBox *)checkBox{
    __weak typeof(self) weakSelf = self;
    if (self.docDelegate) {
        [self.docDelegate cell:weakSelf
                   DidTapCheck:checkBox
                    WithDoctor:self.doctor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)imageDownloadComplete:(NSString *)imageKey andType:(NSString *)type andImage:(UIImage *)image{
    headerImg.image = image;
}

- (void)allImageComplete{
    
}

@end
