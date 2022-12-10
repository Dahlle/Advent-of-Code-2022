$puzzle = Get-Content -Path .\AdventOfCode2022\textfiles\AOC-8.txt
$columns = $puzzle[0].Length
$rows = $puzzle.Count
$forest = New-Object 'object[,]' $rows, $columns

$cordinates = @()
$scenicScore=@()

for ($i = 0; $i -lt $puzzle.Count; $i++){
    $temp=[string]$puzzle[$i];
    for ($x = 0; $x -lt $temp.Length; $x++) {
        $forest[$i, $x]=$temp[$x]
    }
}


function canBeSeen {
    param (
        $in
    )
    $x = $in[0]
    $y = $in[1]
    $currentPos=[string]$x+","+$y
    $checkUp= $true
    $checkDown= $true
    $checkLeft = $true
    $checkRight = $true
    $tempScore=0
    $finalScore=1
    #check left
    for ($i = $y-1; $i -ge 0; $i--) {
        if($forest[$x,$i] -ge $forest[$x,$y]){
            $checkLeft=$false
            $i=-1
        }
        $tempScore++
    }
    $finalScore*=$tempScore
    $tempScore=0
    #check right
    for ($i = ($y+1); $i -lt $columns; $i++) {
        if($forest[$x,$i] -ge $forest[$x,$y]){
            $checkRight=$false
            $i=$columns
        }
        $tempScore++
    }
    $finalScore*=$tempScore
    $tempScore=0
    #check up
    for ($i = $x-1; $i -ge 0; $i--) {
        if($forest[$i,$y] -ge $forest[$x,$y]){
            $checkUp=$false
            $i=-1
        }
        $tempScore++
    }
    $finalScore*=$tempScore
    $tempScore=0
    #check down
    for ($i = ($x+1); $i -lt $rows; $i++) {
        if($forest[$i,$y] -ge $forest[$x,$y]){
            $checkDown=$false
            $i=$rows
        }
        $tempScore++
    }
    $finalScore*=$tempScore
    $tempScore=0
    if($checkDown -eq $true -or $checkLeft -eq $true -or $checkRight -eq $true -or $checkUp -eq $true ){
        return $true,$finalScore
    }
    else{
        return $false,$finalScore
    }
}

for ($x = 1; $x -lt $rows-1; $x++) { 
    for ($y = 1; $y -lt $columns-1; $y++) {
        $result = canBeSeen($x,$y)
        if($result[0] -eq $true){
            $cordinates+=[string]$x+","+$y
        }
        $scenicScore+=$result[1]
    }
}
for ($i = 0; $i -lt $rows; $i++) {
    $cordinates+=[string]"0,"+$i
    $cordinates+=[string]($columns-1)+","+$i
}
for ($i = 0; $i -lt $columns; $i++) {
    $cordinates+=[string]$i+",0"
    $cordinates+=[string]$i+","+($rows-1)
}
$cordinates = $cordinates | sort | Get-Unique
$scenicScore = $scenicScore | sort
$scenicScore[-1]
$cordinates.Count

#det går att göra detta på bättre sätt men jag ligger efter i dagar så detta får duga