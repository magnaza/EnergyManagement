
#---------------------------------------inputs------------------------------------------------------------#

N=50
step=0.05
scale=12

fixed_idle=50
workload=workloads/workload_2.txt
psm=example/psm.txt

#---------------------------------------------------------------------------------------------------------#

>reports/output1_idle.txt
>reports/output1_sleep.txt
>reports/output1_history.txt
>reports/output1_predictive.txt
#>reports/output1_sleepidle.txt

>reports/norm_output1_history.txt
>reports/norm_output1_predictive.txt
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

#----------------------------------------history----------------------------------------------------------#

    outcommand_history=$(./dpm_simulator -psm $psm -wl $workload -h 0.5 0.25 0.15 0.07 0.03 0 $x)

    # The sum of all alpha should be = 1 since we want to make a prediction based statistic on previous values
    # if we have all the previous inactive times = 5 then we get 5*0.5 + 5*0.25 + 5*0.15 + 5*0.07 + 5*0.03 = 5

    filtered_history=$(echo "$outcommand_history" | grep -o -P '\d+\.\d*' | sed '$!d')
    text_history="$i $filtered_history"
    echo $text_history >> reports/output1_history.txt

    echo -n "$x " >> reports/norm_output1_history.txt
    echo "scale=$scale; (1 - $filtered_history/$energy_nodpm) * 100" | bc >> reports/norm_output1_history.txt

#----------------------------------------predictive-------------------------------------------------------#

    outcommand_predictive=$(./dpm_simulator -psm $psm -wl $workload -p 0 $x)
    filtered_predictive=$(echo "$outcommand_predictive" | grep -o -P '\d+\.\d*' | sed '$!d')
    text_predictive="$i $filtered_predictive"
    echo $text_predictive >> reports/output1_predictive.txt

    echo -n "$x " >> reports/norm_output1_predictive.txt
    echo "scale=$scale; (1 - $filtered_predictive/$energy_nodpm) * 100" | bc >> reports/norm_output1_predictive.txt

done

#matlab.exe -r test1
