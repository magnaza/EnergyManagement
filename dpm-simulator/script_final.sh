N=10
step=0.2
scale=8

workload=workloads/workload_1.txt
psm=example/psm.txt

>reports/output1_idle.txt
>reports/output1_sleep.txt
>reports/output1_sleepidle.txt

>reports/norm_output1_idle.txt
>reports/norm_output1_sleep.txt
>reports/norm_output1_sleepidle.txt

energy_nodpm=$(./dpm_simulator -psm $psm -wl $workload -ts 10 | grep -o -P '\d+\.\d*' | sed -n 22p)

for (( c=0; c<=$(bc<<<"$N/$step"); c++))
do
    x=$(echo $(bc<<<"$step * $c"))
    outcommand=$(./dpm_simulator -psm $psm -wl $workload -t $x)
    this=$(echo "$outcommand" | grep -o -P '\d+\.\d*' | sed '$!d')
    those="$x $this"
    echo $those >> reports/output1_idle.txt

    echo -n "$x " >> reports/norm_output1_idle.txt
    echo "scale=$scale; (1 - $this/$energy_nodpm) * 100" | bc >> reports/norm_output1_idle.txt
done

for (( c=0; c<=$(bc<<<"$N/$step"); c++))
do
    x=$(echo $(bc<<<"$step * $c"))
    outcommand=$(./dpm_simulator -psm $psm -wl $workload -ts $x)
    this=$(echo "$outcommand" | grep -o -P '\d+\.\d*' | sed '$!d')
    those="$x $this"
    echo $those >> reports/output1_sleep.txt

    echo -n "$x " >> reports/norm_output1_sleep.txt
    echo "scale=$scale; (1 - $this/$energy_nodpm) * 100" | bc >> reports/norm_output1_sleep.txt
done

fixed_idle=50

for (( c=0; c<=$(bc<<<"$N/$step"); c++))
do
    x=$(echo $(bc<<<"$step * $c"))
    i=$(($x + $fixed_idle))
    outcommand=$(./dpm_simulator -psm $psm -wl $workload -ts $i -t $fixed_idle)
    this=$(echo "$outcommand" | grep -o -P '\d+\.\d*' | sed '$!d')
    those="$i $this"
    echo $those >> reports/output1_sleepidle.txt

    echo -n "$x " >> reports/norm_output1_sleepidle.txt
    echo "scale=$scale; (1 - $this/$energy_nodpm) * 100" | bc >> reports/norm_output1_sleepidle.txt
done




#matlab.exe -r test1