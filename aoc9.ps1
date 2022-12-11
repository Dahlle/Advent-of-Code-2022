$puzzle = Get-Content -Path .\AdventOfCode2022\textfiles\AOC-9.txt

$tailLength=10

$positions=@(,(0,0)*$tailLength)
$previousPosition=@(,(0,0)*$tailLength)

$tailHistory = New-Object System.Collections.Generic.List[object]

function moveTail {
    for ($h = 1; $h -lt $positions.Count; $h++) {
        $needMove = $true;
        $oldPos=$previousPosition[($h-1)].Clone()
        $newPos=$positions[($h-1)].Clone()
        $currentPos=$positions[$h].Clone()
        if(($currentPos[0]-eq $newPos[0] -or $currentPos[0]-eq ($newPos[0]-1) -or $currentPos[0]-eq ($newPos[0]+1))-and
        ($currentPos[1]-eq $newPos[1] -or $currentPos[1]-eq ($newPos[1]-1) -or $currentPos[1]-eq ($newPos[1]+1))){
            $needMove = $false;
        }

        if($needMove-eq$true){
            $tempCurrent=$currentPos.Clone()
            $previousPosition[$h]=$currentPos.Clone()
            $tempNew=$newPos.Clone()
            if($newPos[0]-gt($currentPos[0]+1)-and $newPos[1]-gt($currentPos[1]+1)){
                $tempCurrent[0]=($tempNew[0]-1)
                $tempCurrent[1]=($tempNew[1]-1)
            }
            elseif($newPos[0]-gt($currentPos[0]+1)-and $newPos[1]-lt($currentPos[1]-1)){
                $tempCurrent[0]=($tempNew[0]-1)
                $tempCurrent[1]=($tempNew[1]+1)
            }
            elseif($newPos[0]-lt($currentPos[0]-1)-and $newPos[1]-lt($currentPos[1]-1)){
                $tempCurrent[0]=($tempNew[0]+1)
                $tempCurrent[1]=($tempNew[1]+1)
            }
            elseif($newPos[0]-lt($currentPos[0]-1)-and $newPos[1]-gt($currentPos[1]+1)){
                $tempCurrent[0]=($tempNew[0]+1)
                $tempCurrent[1]=($tempNew[1]-1)
            }
            elseif($newPos[0]-gt($currentPos[0]+1)){
                $tempCurrent[0]=($tempNew[0]-1)
                $tempCurrent[1]=($tempNew[1])
            }
            elseif($newPos[0]-lt($currentPos[0]-1)){
                $tempCurrent[0]=($tempNew[0]+1)
                $tempCurrent[1]=($tempNew[1])
            }
            elseif($newPos[1]-gt($currentPos[1]+1)){
                $tempCurrent[0]=($tempNew[0])
                $tempCurrent[1]=($tempNew[1]-1)
            }
            elseif($newPos[1]-lt($currentPos[1]-1)){
                $tempCurrent[0]=($tempNew[0])
                $tempCurrent[1]=($tempNew[1]+1)
            }

            $positions[$h]=$tempCurrent.Clone();
        }
    }
    # $logg=""
    # for ($i = 0; $i -lt $positions.Count; $i++) {
    #     $temp=$positions[$i]
    #     $logg+=[string]$temp[0]+","+$temp[1]+" "
    # }
    # $logg=[string]$row+" - "+$logg
    # $logg 
}
foreach($row in $puzzle){
    $row=$row-split(" ")
    $steps=[int]$row[1]
    if($row[0]-eq"R"){
        for ($i = 0; $i -lt $steps; $i++){
            $headPos = $positions[0].Clone();
            $headPos[1]++;
            $previousPosition[0]=$positions[0].Clone();
            $positions[0]=$headPos.Clone();
            moveTail;
            $temp=$positions[-1].Clone()
            $tailHistory.add([string]$temp[0]+","+$temp[1])
        }
    }
    elseif ($row[0]-eq"L") {
        for ($i = 0; $i -lt $steps; $i++){
            $headPos = $positions[0].Clone();
            $headPos[1]--;
            $previousPosition[0]=$positions[0].Clone();
            $positions[0]=$headPos.Clone();
            moveTail;
            $temp=$positions[-1].Clone()
            $tailHistory.add([string]$temp[0]+","+$temp[1])
        }
    }
    elseif ($row[0]-eq"U") {
        for ($i = 0; $i -lt $steps; $i++){
            $headPos = $positions[0].Clone();
            $headPos[0]++;
            $previousPosition[0]=$positions[0].Clone();
            $positions[0]=$headPos.Clone();
            moveTail;
            $temp=$positions[-1].Clone()
            $tailHistory.add([string]$temp[0]+","+$temp[1])
            
        }
    }
    elseif ($row[0]-eq"D") {
        for ($i = 0; $i -lt $steps; $i++){
            $headPos = $positions[0].Clone();
            $headPos[0]--;
            $previousPosition[0]=$positions[0].Clone();
            $positions[0]=$headPos.Clone();
            moveTail;
            $temp=$positions[-1].Clone()
            $tailHistory.add([string]$temp[0]+","+$temp[1])
        }
    }
    # $logg=""
    # for ($i = 0; $i -lt $positions.Count; $i++) {
    #     $temp=$positions[$i]
    #     $logg+=[string]$temp[0]+","+$temp[1]+" "
    # }
    # $logg=[string]$row+" - "+$logg
    # $logg
}
$tailHistory = $tailHistory | sort | Get-Unique
$tailHistory.Count

Remove-Variable * -ErrorAction SilentlyContinue