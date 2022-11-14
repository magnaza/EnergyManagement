
#---------------------------------------inputs------------------------------------------------------------#

N=100
step=0.1
scale=12

fixed_idle=50
workload=workloads/workload_1.txt
psm=example/psm.txt

#---------------------------------------------------------------------------------------------------------#

>reports/output1_idle.txt
>reports/output1_sleep.txt
#>reports/output1_sleepidle.txt

>reports/norm_output1_idle.txt
>reports/norm_output1_sleep.txt
#>reports/norm_output1_sleepidle.txt

energy_nodpm=$(./dpm_simulator -psm $psm -wl $workload -ts 10 | grep -o -P '\d+\.\d*' | sed -n 22p)

for (( c=0; c<=$(bc<<<"$N/$step"); c++))
do
    
    x=$(echo $(bc<<<"$step * $c"))

#---------------------------------------idle--------------------------------------------------------------#

    outcommand_idle=$(./dpm_simulator -psm $psm -wl $workload -t $x)
    filtered_idle=$(echo "$outcommand_idle" | grep -o -P '\d+\.\d*' | sed '$!d')
    text_idle="$x $filtered_idle"
    echo $text_idle >> reports/output1_idle.txt

    echo -n "$x " >> reports/norm_output1_idle.txt
    echo "scale=$scale; (1 - $filtered_idle/$energy_nodpm) * 100" | bc >> reports/norm_output1_idle.txt

#----------------------------------------sleep------------------------------------------------------------#

    outcommand_sleep=$(./dpm_simulator -psm $psm -wl $workload -ts $x)
    filtered_sleep=$(echo "$outcommand_sleep" | grep -o -P '\d+\.\d*' | sed '$!d')
    text_sleep="$x $filtered_sleep"
    echo $text_sleep >> reports/output1_sleep.txt

    echo -n "$x " >> reports/norm_output1_sleep.txt
    echo "scale=$scale; (1 - $filtered_sleep/$energy_nodpm) * 100" | bc >> reports/norm_output1_sleep.txt

#----------------------------------------sleep&idle-------------------------------------------------------#

#    i=$(($x + $fixed_idle))
#    outcommand_sleepidle=$(./dpm_simulator -psm $psm -wl $workload -ts $i -t $fixed_idle)
#    filtered_sleepidle=$(echo "$outcommand_sleepidle" | grep -o -P '\d+\.\d*' | sed '$!d')
#    text_sleepidle="$i $filtered_sleepidle"
#    echo $text_sleepidle >> reports/output1_sleepidle.txt

#    echo -n "$x " >> reports/norm_output1_sleepidle.txt
#    echo "scale=$scale; (1 - $filtered_sleepidle/$energy_nodpm) * 100" | bc >> reports/norm_output1_sleepidle.txt

done

#matlab.exe -r test1
