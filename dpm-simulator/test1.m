load workloads\workload_1.txt
[n] = size(workload_1)
[n, p] = size(workload_1)
t = 1:n

figure
hold on
plot(t, workload_1)
%plot(t, workload_1)
legend('value1','value2')