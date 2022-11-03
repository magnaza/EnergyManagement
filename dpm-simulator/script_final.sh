N=100
>reports/output1_idle.txt
for (( c=0; c<=$N; c++))
do
    outcommand=$(./dpm_simulator -psm example/psm.txt -wl workloads/workload_1.txt -t $c)
    that="$c          "
    this=$(echo "$outcommand" | grep -o -P '\d+\.\d*' | sed '$!d')
    those="$that $this"
    echo $those >> reports/output1_idle.txt
done

#matlab.exe -r test1