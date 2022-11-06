load reports\output1_idle.txt
[n] = size(output1_idle)
[n, p] = size(output1_idle)
t = 1:n
table1=array2table(output1_idle)
figure
hold on
plot(t, table1.output1_idle2)

load reports\output1_sleep.txt
[n] = size(output1_sleep)
[n, p] = size(output1_sleep)
t = 1:n
table2=array2table(output1_sleep)
plot(t, table2.output1_sleep2)
legend('idle', 'sleep')