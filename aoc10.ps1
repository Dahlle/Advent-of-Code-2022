$puzzle = Get-Content -Path .\AdventOfCode2022\textfiles\AOC-10.txt

$part=2

$x=1
$cycle=0
$signal=0
$crt = @()
$puzzleIndex=0

foreach($row in $puzzle){
    $puzzleIndex++
    $row=$row-split(" ")
    $time=0
    if($row[0]-eq"noop"){
        $time=1;
    }
    else{
        $time=2;
    }
    $loop=0
    while ($loop -lt $time) {
        if($cycle -eq 40 -and $part-eq 2){
            $cycle=0
        }
        if($cycle-gt ($x-2)-and $cycle-lt($x+2)){
            $crt+="#"
        }
        else{
            $crt+="."
        }
        $cycle++
        
        
        for ($i = 20; $i -lt 221; $i+=40) {
            if($i-eq$cycle){
                $signal+=($cycle*$x)
            }
        }
        $loop++;
    }
    $x+=[int]$row[1]

}
$signal
for ($i = 0; $i -lt 6; $i++) {
    [string]$crt[(40*$i)..((40*($i+1))-1)]
}
