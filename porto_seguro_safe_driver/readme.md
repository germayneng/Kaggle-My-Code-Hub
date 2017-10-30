Model 1: score 0.28X

$ python3 preprocessing.py 
<br>
$ Rscript feature_engineering.R
<br>
$ python3 lgbm.py 

# Model 1 


```
Pretty consistent cv for both. 

Model | des| cv | LB |  
--- | --- | --- | --- 
LGBM | normal prep | 0.28388587 | 0.278
LGBM | ohe on 8 cat |  0.2834999 | 0.277
LGBM | LOO on 1618, 0609 | 0.28337639620598 | 0.276


 Starting: fold 1
Training until validation scores don't improve for 100 rounds.
[100]   valid_0's auc: 0.611438 valid_0's gini: 0.222609
[200]   valid_0's auc: 0.627197 valid_0's gini: 0.254394
[300]   valid_0's auc: 0.634061 valid_0's gini: 0.268121
[400]   valid_0's auc: 0.637309 valid_0's gini: 0.274618
[500]   valid_0's auc: 0.639135 valid_0's gini: 0.27827
[600]   valid_0's auc: 0.639898 valid_0's gini: 0.279795
[700]   valid_0's auc: 0.640543 valid_0's gini: 0.281086
[800]   valid_0's auc: 0.641146 valid_0's gini: 0.282293
[900]   valid_0's auc: 0.641683 valid_0's gini: 0.283365
[1000]  valid_0's auc: 0.642039 valid_0's gini: 0.284078
[1100]  valid_0's auc: 0.64214  valid_0's gini: 0.284279
[1200]  valid_0's auc: 0.642306 valid_0's gini: 0.284612
[1300]  valid_0's auc: 0.642305 valid_0's gini: 0.28461
[1400]  valid_0's auc: 0.642381 valid_0's gini: 0.284762

 evaluating model.... 

Feature importances: [1065, 391, 1446, 322, 739, 0, 0, 1, 0, 3, 1179, 719, 821, 2439, 730, 106, 274, 167, 166, 712, 284, 52, 391, 0, 1231, 353, 490, 1592, 1772, 768, 526, 622]
            feature  importances
8     ps_ind_13_bin            0
23    ps_car_10_cat            0
5     ps_ind_10_bin            0
6     ps_ind_11_bin            0
7     ps_ind_12_bin            1
9         ps_ind_14            3
21    ps_car_08_cat           52
15    ps_car_02_cat          106
18    ps_car_05_cat          166
17    ps_car_04_cat          167
16    ps_car_03_cat          274
20    ps_car_07_cat          284
3     ps_ind_04_cat          322
25        ps_car_11          353
22    ps_car_09_cat          391
1     ps_ind_02_cat          391
26        ps_car_12          490
30      ps_ind_0609          526
31  ps_ind_1618_bin          622
19    ps_car_06_cat          712
11        ps_reg_01          719
14    ps_car_01_cat          730
4     ps_ind_05_cat          739
29        ps_car_15          768
12        ps_reg_02          821
0         ps_ind_01         1065
10        ps_ind_15         1179
24    ps_car_11_cat         1231
2         ps_ind_03         1446
27        ps_car_13         1592
28        ps_car_14         1772
13        ps_reg_03         2439

 gini is 0.28476159459861666 for fold 1

 Starting: fold 2
Training until validation scores don't improve for 100 rounds.
[100]   valid_0's auc: 0.607489 valid_0's gini: 0.214593
[200]   valid_0's auc: 0.627895 valid_0's gini: 0.255792
[300]   valid_0's auc: 0.634365 valid_0's gini: 0.26873
[400]   valid_0's auc: 0.638239 valid_0's gini: 0.276479
[500]   valid_0's auc: 0.640213 valid_0's gini: 0.280427
[600]   valid_0's auc: 0.64111  valid_0's gini: 0.282219
[700]   valid_0's auc: 0.641885 valid_0's gini: 0.283771
[800]   valid_0's auc: 0.642429 valid_0's gini: 0.284857
[900]   valid_0's auc: 0.642755 valid_0's gini: 0.28551
[1000]  valid_0's auc: 0.64296  valid_0's gini: 0.285921
[1100]  valid_0's auc: 0.64315  valid_0's gini: 0.286299
[1200]  valid_0's auc: 0.643128 valid_0's gini: 0.286255
[1300]  valid_0's auc: 0.643152 valid_0's gini: 0.286304
Early stopping, best iteration is:
[1277]  valid_0's auc: 0.64322  valid_0's gini: 0.286441

 evaluating model.... 

Feature importances: [970, 540, 1302, 344, 706, 0, 0, 1, 0, 0, 749, 835, 810, 2037, 686, 157, 333, 209, 200, 694, 282, 41, 455, 0, 961, 295, 507, 1627, 1418, 552, 481, 601]
            feature  importances
9         ps_ind_14            0
23    ps_car_10_cat            0
8     ps_ind_13_bin            0
5     ps_ind_10_bin            0
6     ps_ind_11_bin            0
7     ps_ind_12_bin            1
21    ps_car_08_cat           41
15    ps_car_02_cat          157
18    ps_car_05_cat          200
17    ps_car_04_cat          209
20    ps_car_07_cat          282
25        ps_car_11          295
16    ps_car_03_cat          333
3     ps_ind_04_cat          344
22    ps_car_09_cat          455
30      ps_ind_0609          481
26        ps_car_12          507
1     ps_ind_02_cat          540
29        ps_car_15          552
31  ps_ind_1618_bin          601
14    ps_car_01_cat          686
19    ps_car_06_cat          694
4     ps_ind_05_cat          706
10        ps_ind_15          749
12        ps_reg_02          810
11        ps_reg_01          835
24    ps_car_11_cat          961
0         ps_ind_01          970
2         ps_ind_03         1302
28        ps_car_14         1418
27        ps_car_13         1627
13        ps_reg_03         2037

 gini is 0.2864407426508979 for fold 2

 Starting: fold 3
Training until validation scores don't improve for 100 rounds.
[100]   valid_0's auc: 0.612299 valid_0's gini: 0.224566
[200]   valid_0's auc: 0.626554 valid_0's gini: 0.253106
[300]   valid_0's auc: 0.633099 valid_0's gini: 0.266197
[400]   valid_0's auc: 0.636161 valid_0's gini: 0.272321
[500]   valid_0's auc: 0.637902 valid_0's gini: 0.275804
[600]   valid_0's auc: 0.639    valid_0's gini: 0.277999
[700]   valid_0's auc: 0.639705 valid_0's gini: 0.279409
[800]   valid_0's auc: 0.640189 valid_0's gini: 0.280378
[900]   valid_0's auc: 0.640294 valid_0's gini: 0.280587
Early stopping, best iteration is:
[861]   valid_0's auc: 0.640405 valid_0's gini: 0.28081

 evaluating model.... 

Feature importances: [745, 275, 1039, 315, 568, 0, 0, 0, 0, 7, 590, 465, 553, 1273, 530, 41, 197, 168, 57, 359, 255, 45, 317, 0, 519, 215, 269, 1030, 886, 355, 313, 451]
            feature  importances
23    ps_car_10_cat            0
8     ps_ind_13_bin            0
7     ps_ind_12_bin            0
6     ps_ind_11_bin            0
5     ps_ind_10_bin            0
9         ps_ind_14            7
15    ps_car_02_cat           41
21    ps_car_08_cat           45
18    ps_car_05_cat           57
17    ps_car_04_cat          168
16    ps_car_03_cat          197
25        ps_car_11          215
20    ps_car_07_cat          255
26        ps_car_12          269
1     ps_ind_02_cat          275
30      ps_ind_0609          313
3     ps_ind_04_cat          315
22    ps_car_09_cat          317
29        ps_car_15          355
19    ps_car_06_cat          359
31  ps_ind_1618_bin          451
11        ps_reg_01          465
24    ps_car_11_cat          519
14    ps_car_01_cat          530
12        ps_reg_02          553
4     ps_ind_05_cat          568
10        ps_ind_15          590
0         ps_ind_01          745
28        ps_car_14          886
27        ps_car_13         1030
2         ps_ind_03         1039
13        ps_reg_03         1273

 gini is 0.28080980538233996 for fold 3

 Starting: fold 4
Training until validation scores don't improve for 100 rounds.
[100]   valid_0's auc: 0.606574 valid_0's gini: 0.212965
[200]   valid_0's auc: 0.626702 valid_0's gini: 0.253404
[300]   valid_0's auc: 0.635786 valid_0's gini: 0.271571
[400]   valid_0's auc: 0.639529 valid_0's gini: 0.279059
[500]   valid_0's auc: 0.641231 valid_0's gini: 0.282461
[600]   valid_0's auc: 0.642223 valid_0's gini: 0.284446
[700]   valid_0's auc: 0.643134 valid_0's gini: 0.286268
[800]   valid_0's auc: 0.643768 valid_0's gini: 0.287536
[900]   valid_0's auc: 0.644079 valid_0's gini: 0.288157
[1000]  valid_0's auc: 0.644424 valid_0's gini: 0.288848
[1100]  valid_0's auc: 0.644852 valid_0's gini: 0.289703
[1200]  valid_0's auc: 0.645151 valid_0's gini: 0.290303
[1300]  valid_0's auc: 0.645149 valid_0's gini: 0.290298
Early stopping, best iteration is:
[1223]  valid_0's auc: 0.645265 valid_0's gini: 0.290529

 evaluating model.... 

Feature importances: [836, 477, 1291, 318, 665, 0, 0, 1, 0, 4, 849, 784, 673, 1859, 710, 99, 295, 176, 234, 517, 295, 63, 418, 0, 908, 390, 390, 1619, 1473, 702, 393, 508]
            feature  importances
8     ps_ind_13_bin            0
23    ps_car_10_cat            0
5     ps_ind_10_bin            0
6     ps_ind_11_bin            0
7     ps_ind_12_bin            1
9         ps_ind_14            4
21    ps_car_08_cat           63
15    ps_car_02_cat           99
17    ps_car_04_cat          176
18    ps_car_05_cat          234
16    ps_car_03_cat          295
20    ps_car_07_cat          295
3     ps_ind_04_cat          318
26        ps_car_12          390
25        ps_car_11          390
30      ps_ind_0609          393
22    ps_car_09_cat          418
1     ps_ind_02_cat          477
31  ps_ind_1618_bin          508
19    ps_car_06_cat          517
4     ps_ind_05_cat          665
12        ps_reg_02          673
29        ps_car_15          702
14    ps_car_01_cat          710
11        ps_reg_01          784
0         ps_ind_01          836
10        ps_ind_15          849
24    ps_car_11_cat          908
2         ps_ind_03         1291
28        ps_car_14         1473
27        ps_car_13         1619
13        ps_reg_03         1859

 gini is 0.29052942540032445 for fold 4

 Starting: fold 5
Training until validation scores don't improve for 100 rounds.
[100]   valid_0's auc: 0.609714 valid_0's gini: 0.219524
[200]   valid_0's auc: 0.625124 valid_0's gini: 0.25025
[300]   valid_0's auc: 0.630446 valid_0's gini: 0.260891
[400]   valid_0's auc: 0.633207 valid_0's gini: 0.266414
[500]   valid_0's auc: 0.635137 valid_0's gini: 0.270274
[600]   valid_0's auc: 0.636186 valid_0's gini: 0.272372
[700]   valid_0's auc: 0.636729 valid_0's gini: 0.273459
[800]   valid_0's auc: 0.637009 valid_0's gini: 0.274017
[900]   valid_0's auc: 0.637252 valid_0's gini: 0.274504
[1000]  valid_0's auc: 0.63755  valid_0's gini: 0.275101
[1100]  valid_0's auc: 0.637811 valid_0's gini: 0.275623
[1200]  valid_0's auc: 0.638153 valid_0's gini: 0.276305
[1300]  valid_0's auc: 0.63827  valid_0's gini: 0.27654
[1400]  valid_0's auc: 0.63857  valid_0's gini: 0.27714

 evaluating model.... 

Feature importances: [996, 472, 1527, 312, 822, 0, 0, 3, 0, 3, 891, 844, 865, 2416, 823, 51, 266, 209, 95, 852, 315, 100, 375, 5, 1021, 277, 440, 1917, 1703, 788, 529, 624]
            feature  importances
8     ps_ind_13_bin            0
6     ps_ind_11_bin            0
5     ps_ind_10_bin            0
9         ps_ind_14            3
7     ps_ind_12_bin            3
23    ps_car_10_cat            5
15    ps_car_02_cat           51
18    ps_car_05_cat           95
21    ps_car_08_cat          100
17    ps_car_04_cat          209
16    ps_car_03_cat          266
25        ps_car_11          277
3     ps_ind_04_cat          312
20    ps_car_07_cat          315
22    ps_car_09_cat          375
26        ps_car_12          440
1     ps_ind_02_cat          472
30      ps_ind_0609          529
31  ps_ind_1618_bin          624
29        ps_car_15          788
4     ps_ind_05_cat          822
14    ps_car_01_cat          823
11        ps_reg_01          844
19    ps_car_06_cat          852
12        ps_reg_02          865
10        ps_ind_15          891
0         ps_ind_01          996
24    ps_car_11_cat         1021
2         ps_ind_03         1527
28        ps_car_14         1703
27        ps_car_13         1917
13        ps_reg_03         2416

 gini is 0.2771398880713809 for fold 5

 averging test predictions....


 Gini is 0.28388587677235994 for full training set (cross validation score)
```
