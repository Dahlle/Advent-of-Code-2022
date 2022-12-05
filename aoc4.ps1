$puzzle = Get-Content -Path .\textfiles\AOC-4.txt
$result = 0;
$resut2 = 0;


foreach($row in $puzzle){
    #part 1
    $firstElf = (($row -split(","))[0] -split ("-")) | % {iex $_}
    $secondElf = (($row -split(","))[1] -split ("-")) | % {iex $_}
    if(
    (($firstElf[0] -ge $secondElf[0]) -and ($firstElf[1] -le $secondElf[1])) -or 
    (($secondElf[0] -ge $firstElf[0]) -and ($secondElf[1] -le $firstElf[1])))
    {
        $result++
    }
    #part 2
    $AC = @($firstElf[0],$secondElf[0]) | measure -Maximum
    $BD = @($secondElf[1],$firstElf[1]) | measure -Minimum
    if(($AC.Maximum -le $BD.Minimum)){
         $resut2++;
    }
}
$result
$resut2
Remove-Variable * -ErrorAction SilentlyContinue