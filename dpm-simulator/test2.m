load reports\norm_output1_sleeppp.txt

[n] = size(norm_output1_sleeppp)
[n, p] = size(norm_output1_sleeppp)
t = 1:n
table1=array2table(norm_output1_sleeppp)
figure
hold on
title('Workload 1')
xlabel('Timeout Time') 
ylabel('Percentage of Saved Energy') 
plot(table1.norm_output1_sleeppp1, table1.norm_output1_sleeppp2)
legend('sleep')
load reports\norm_output1_predictive.txt
[n] = size(norm_output1_predictive)
[n, p] = size(norm_output1_predictive)
t = 1:n
table2=array2table(norm_output1_predictive)
plot(table2.norm_output1_predictive1, table2.norm_output1_predictive2)
legend('sleep', 'predictive')