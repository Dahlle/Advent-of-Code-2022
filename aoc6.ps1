$puzzle = Get-Content -Path .\textfiles\AOC-6.txt
$result = "";

$marker = 14 #change to 14 if part 2

for($x=0;$x-le$puzzle.Length;$x++){

    $tempArray=$puzzle[$x..($x+$marker-1)] | Sort-Object| Get-Unique -AsString
    if($tempArray.Length -eq $marker){
        $result=$x+$marker
        break
    }
}
$result
Remove-Variable * -ErrorAction SilentlyContinue