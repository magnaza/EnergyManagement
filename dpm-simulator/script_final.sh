N=10
scale=8
>reports/output1_idle.txt
>reports/output1_sleep.txt
>reports/output1_sleepidle.txt

>reports/norm_output1_idle.txt
>reports/norm_output1_sleep.txt
>reports/norm_output1_sleepidle.txt
energy_nodpm=$(./dpm_simulator -psm example/psm.txt -wl workloads/workload_1.txt -ts 10 | grep -o -P '\d+\.\d*' | sed -n 22p)

for (( c=0; c<=$N; c++))
do
    outcommand=$(./dpm_simulator -psm example/psm.txt -wl workloads/workload_1.txt -t $c)
    that="$c          "
    this=$(echo "$outcommand" | grep -o -P '\d+\.\d*' | sed '$!d')
    those="$that $this"
    echo $those >> reports/output1_idle.txt

    echo -n "$c " >> reports/norm_output1_idle.txt
    echo "scale=$scale; (1 - $this/$energy_nodpm) * 100" | bc >> reports/norm_output1_idle.txt
done

for (( c=0; c<=$N; c++))
do
    outcommand=$(./dpm_simulator -psm example/psm.txt -wl workloads/workload_1.txt -ts $c)
    that="$c          "
    this=$(echo "$outcommand" | grep -o -P '\d+\.\d*' | sed '$!d')
    those="$that $this"
    echo $those >> reports/output1_sleep.txt

    echo -n "$c " >> reports/norm_output1_sleep.txt
    echo "scale=$scale; (1 - $this/$energy_nodpm) * 100" | bc >> reports/norm_output1_sleep.txt
done

fixed_idle=50

for (( c=0; c<=$N; c++))
do
    i=$(($c + $fixed_idle))
    outcommand=$(./dpm_simulator -psm example/psm.txt -wl workloads/workload_1.txt -ts $i -t $fixed_idle)
    that="$c          "
    this=$(echo "$outcommand" | grep -o -P '\d+\.\d*' | sed '$!d')
    those="$that $this"
    echo $those >> reports/output1_sleepidle.txt

    echo -n "$c " >> reports/norm_output1_sleepidle.txt
    echo "scale=$scale; (1 - $this/$energy_nodpm) * 100" | bc >> reports/norm_output1_sleepidle.txt
done




#matlab.exe -r test1