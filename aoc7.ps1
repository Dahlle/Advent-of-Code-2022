$puzzle = Get-Content -Path .\AdventOfCode2022\textfiles\AOC-7.txt 
[Hashtable[]]$allDirs = $null
$result = 0

#har en känsla att jag kommer behöva denna
function checkDirSize {
    #egentligen borde jag använda mig av path och söka efter rätt path istället för att ta första bästa. men detta funkar så w/e för nu
    param (
        $dirName
    )
    for($x=0;$x-lt $allDirs.Count;$x++){
        $row = $allDirs[$x]
        if($row.Name -eq $dirName -and $row.Size-eq 0){
            $value =0
            $folder = $row.Contains
                for($i = 0; $i -lt $folder.Count; $i++) {
                    if($folder[$i].StartsWith("dir")){
                        $value+=checkDirSize($folder[$i])
                    }
                    elseif(!$folder[$i].StartsWith("$ cd")){
                        $value+=($folder[$i]-split(" "))[0]
                    }
                    $allDirs[$x].Size = $value
                }
                return $value
        }   
    }
}
$id = 1
$currentPath=@()
for($i = 0; $i -lt $puzzle.Count; $i++) {
    if(!($puzzle[$i].StartsWith("$ cd .."))){
        if($puzzle[$i].StartsWith("$ cd ") -or $i -eq ($puzzle.Count-1)){
            #this is where a new folder starts
            if($i-eq 0){
                $tempName="/"
            }
            elseif($i -eq ($puzzle.Count-1)){
                $allDirs+=@{Name=$tempName;Contains=$puzzle[$tempIndex..($i)];Size=0;Path=$currentPath}
            }
            else{
                $allDirs+=@{Name=$tempName;Contains=$puzzle[$tempIndex..($i-1)];Size=0;Path=$currentPath}
                $temp = $puzzle[$i];
                $tempName="dir "+  ($temp[5..$temp.Length]-join "")
            }
            $currentPath+=$tempName
        }
        elseif($puzzle[$i].StartsWith("$ ls")) {
            #add everything to the current $allDirs[x]
            $tempIndex = $i+1
        }
    }
    elseif(($puzzle[$i].StartsWith("$ cd .."))-eq $true){
        $currentPath=$currentPath[0..($currentPath.Length-2)];
    }
}
$noecho = checkDirSize("/")
#kolla genom och räkna ut alla dir sizes
foreach($row in $allDirs){
    if($row.Size -lt 100000){
        $result+=$row.Size
    }
}
$result

#part 2
$freeSpace = 70000000 - $allDirs[0].Size
$deleteDirSize = 30000000 - $freeSpace

$result2=0
for ($i = 0; $i -lt $allDirs.Count; $i++){
    if($result2-eq 0){
        $result2=$allDirs[$i].Size
    }
    if($allDirs[$i].Size -ge $deleteDirSize-and $allDirs[$i].Size -le $result2){
        $result2=$allDirs[$i].Size
    }
}
$result2
 