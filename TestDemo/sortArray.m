//
//  sortArray.m
//  面试题demo
//
//  Created by PingAnXL on 17/3/29.
//  Copyright © 2017年 PingAnXL. All rights reserved.
//

#import "sortArray.h"

@implementation sortArray

- (void)sortArray:(sortNrayType)sorType {


    switch (sorType) {
        case sortNrayType1:
            [self _firstModtod];
            break;
        case sortNrayType2:
            [self _secodeModtod];
            break;
        case sortNrayType3:
            [self _thirdModtod];
            break;
        case sortNrayType4:
            
            break;
            
        default:
            break;
    }


}

// 选择排序
- (void)_firstModtod {
    
    NSArray * array = @[@100,@34,@22,@88,@77,@4,@1000];
    NSMutableArray * array2 = [NSMutableArray arrayWithArray:array];
    
    for (int i = 0; i < array2.count; i++) {
        
        for (int j = i + 1; j < array2.count ; j++) {

            if (array2[i] > array2[j]) {
                [array2 exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
            
        }
        
    }
    
    NSLog(@"%@",array2);

}
// 冒泡排序
- (void)_secodeModtod {

    NSArray * array = @[@100,@34,@22,@88,@77,@4,@1000];
    NSMutableArray * array2 = [NSMutableArray arrayWithArray:array];

    for (int i = 0; i < array2.count; i ++) {
        
        for (int j = 0; j < array2.count - 1; j ++) {
            
            if (array2[j] > array2[j + 1]) {
                
                [array2 exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                
            }
            
        }
   
    }
    
    NSLog(@"%@",array2);
    

}

- (void)_thirdModtod {
 
    
    int i,j;
    int t; //临时变量
    
    int a[10] = {10,2,3,1,100,22,0,1,99,23};
    /*输入10个数据*/
//    for(i=0;i<10;i++){
//        scanf("%d",&a[i]);
//    }
    
    /*开始冒泡排序*/
    for(j=0;j<9;j++){
        
        for(i=0;i<9-j;i++)
            
            if(a[i]<a[i+1]) {   /*相邻元素比较，交换 大的放前面（看需求）*/
                
                t=a[i];
                
                a[i]=a[i+1];
                
                a[i+1]=t;
            }
    }
    
    /*验证：输出排序结果*/
    for(i=0;i<10;i++) {
        
        printf("%d",a[i]);
    }


}



@end
