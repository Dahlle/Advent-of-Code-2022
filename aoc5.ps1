$puzzle = Get-Content -Path .\textfiles\AOC-5.txt
$result = "";

$boxPlacement = @();
$columns = @("");
$rows = @();

#first we sort out this mess
foreach($row in $puzzle){
    if(!$row.StartsWith("move") -and $row -ne ""){
        $boxPlacement+=$row;
    }
    else{
        break
    }
}
#second array for all moves
$moves = $puzzle[($boxPlacement.Length+1)..($puzzle.Length)]

#lite fult men här preppar jag kolumnerna
$columnCount = $boxPlacement[$boxPlacement.Length-1]
$boxPlacement = $boxPlacement[0..($boxPlacement.Length-2)]
$columnCount=$columnCount -split("   ") | % {iex $_;}
for($x=0;$x-lt $columnCount.Length-1;$x++){
        $columns+=""
}

#dags att populera raderna
foreach($row in $boxPlacement){
    $temp = ""
    for($x=1;$x -lt $row.Length;$x+=4){
        $temp+=$row[$x]
    }
    $rows+=$temp
}

#och sedan vända på skiten för att göra det till kolumner
foreach($row in $rows){
    $temp = ""
    for($x=0;$x -le ($row.Length-1);$x++){
        if($row[$x]-ne " "){
            $columns[$x]+=$row[$x];
        }
    }
}

#dags att räkna ut skiten då
#[0] = antal
#[1] = från kolumn
#[2] = till kolumn

foreach($row in $moves){
    #part 1 and part 2 lol
    $row=$row.ToString() -replace "[ ]","" -replace"move","" -split("from|to")| % {iex $_;}
    $tempMove=$columns[$row[1]-1]
    $columns[$row[1]-1]= $tempMove.Substring($row[0])
    $tempMove=($tempMove[0..($row[0]-1)]) -join ""
    #comment in this for part 1
    # $tempMove=$tempMove.ToCharArray()
    # [array]::Reverse($tempMove)
    $columns[$row[2]-1]= $tempMove + $columns[$row[2]-1] -join ""
}
foreach($row in $columns){
    $result+=$row[0]
}
$result
Remove-Variable * -ErrorAction SilentlyContinue