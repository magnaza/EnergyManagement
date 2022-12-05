load reports\norm_output1_idle.txt

[n] = size(norm_output1_idle)
[n, p] = size(norm_output1_idle)
t = 1:n
table1=array2table(norm_output1_idle)
figure
hold on
title('Workload 2')
xlabel('Timeout Time') 
ylabel('Percentage of Saved Energy') 
plot(table1.norm_output1_idle1, table1.norm_output1_idle2)
legend('idle')
load reports\norm_output1_sleep.txt
[n] = size(norm_output1_sleep)
[n, p] = size(norm_output1_sleep)
t = 1:n
table2=array2table(norm_output1_sleep)
plot(table2.norm_output1_sleep1, table2.norm_output1_sleep2)
legend('idle', 'sleep')