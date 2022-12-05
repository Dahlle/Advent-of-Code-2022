$puzzle = Get-Content -Path .\textfiles\AOC-3.txt
$letterarray = Get-Content -Path .\textfiles\alphabet-aoc3.txt
$result = 0
$result2 = 0

#part 1
function calculatePriority {
    param (
        $letter
    )
    $letter+=""
    $prio = $letterarray.IndexOf($letter.toLower()) + 1
    if($letter -ceq $letter.ToUpper()){
        $prio=26+$prio
    }
    return $prio
}

foreach($row in $puzzle){
    $half = ($row.Length)/2
    $pocket1 = ($row[0..($half-1)])
    $pocket2 = ($row[$half..($row.Length-1)])
    $match = ""
    foreach($letter in $pocket1){
        if($pocket2.Contains($letter)){
            $match = $letter
            break
        }
    }

    $result+=calculatePriority($match)
}
$result


#part 2
$counter = 0
$array = @()
$badge=""
foreach($row in $puzzle){
    $counter++
    $array+=$row
    if($counter-eq 3){
        $letter = $array[0].ToCharArray()
        for($x=0;$x -le $letter.Length;$x++){
            if($array[1].ToCharArray().Contains($letter[$x]) -and $array[2].ToCharArray().Contains($letter[$x])){
                $badge = $letter[$x]
                $x = $letter.Length+1
            }
        }
        $counter = 0
        $array = @()
        $result2+=calculatePriority($badge)
        $badge=""
    }
}
$result2