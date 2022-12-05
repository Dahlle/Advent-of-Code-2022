$puzzle = Get-Content -Path .\textfiles\AOC-1.txt
$temp = 0

#part 1
$array = @()
foreach($row in $puzzle){
    if($row -ne ""){
        $temp += $row
    }
    else{
        if($null -eq $array[0]){
            $array += $temp
            $temp = 0
        }
        elseif($null -ne $array[0] -and $array[0] -lt $temp){
            $array = ,$temp + $array
            $temp = 0
        }
        elseif($null -ne $array[0] -and $array[0] -gt $temp){
            $array += $temp
            $temp = 0
        }
    }
}
$array[0]

#part 2
$array2 =@(0,0,0)
foreach($row in $array){
    if($row -gt $array2[0]){
        $array2[0] = $row
    }
    elseif($row -gt $array2[1]){
        $array2[1] = $row
    }
    elseif($row -gt $array2[2]){
        $array2[2] = $row
    }
}
    

$array2[0] + $array2[1] + $array2[2]
