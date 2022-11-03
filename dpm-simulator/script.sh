>reports/final_result.txt
for ((i=0;i<10;i++))
do
    ./dpm_simulator -t $i -psm example/psm.txt -wl workloads/workload_1.txt > reports/partial_result.txt
    echo "results for timeout:$i" >> reports/final_result.txt
    sed '19q;d' reports/partial_result.txt >> reports/final_result.txt
    echo "" >> reports/final_result.txt
    echo "" >> reports/final_result.txt
    echo "" >> reports/final_result.txt
done

#matlab.exe -r test1