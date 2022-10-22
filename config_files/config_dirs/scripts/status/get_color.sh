get_color() {
    state=$1
	if (( $(echo "$state <= 10" | bc -l) ))
    then
        echo "#802040"
    elif (( $(echo "$state <= 40" | bc -l) ))
    then
        echo "#804060"
    elif (( $(echo "$state <= 70" | bc -l) ))
    then
        echo "#806040"
    else
        echo "#408060"
    fi
}

