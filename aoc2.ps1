$puzzle = Get-Content -Path .\textfiles\AOC-2.txt
$result = 0

#part 1
function calculateMatch {
    param (
        $match
    )
    switch ($match) {
        #resultat = shape point + match point
        "A Z" {$resultat=3}
        "B Z" {$resultat=9}
        "C Z" {$resultat=6}
        "A X" {$resultat=4}
        "B X" {$resultat=1}
        "C X" {$resultat=7}
        "A Y" {$resultat=8}
        "B Y" {$resultat=5}
        "C Y" {$resultat=2}
    }
    return $resultat
}

foreach($row in $puzzle){
    $res = calculateMatch($row)
    $result+=$res
}
$result
#part 2
$result2 = 0
function calculateMatch {
    param (
        $match
    )
    switch ($match) {
        #resultat = shape point + match point
        "A Z" {$resultat=2 + 6}
        "B Z" {$resultat=3 + 6}
        "C Z" {$resultat=1 + 6}
        "C X" {$resultat=2}
        "A X" {$resultat=3}
        "B X" {$resultat=1}
        "A Y" {$resultat=1 + 3}
        "B Y" {$resultat=2 + 3}
        "C Y" {$resultat=3 + 3}
    }
    return $resultat
}

foreach($row in $puzzle){
    $res = calculateMatch($row)
    $result2+=$res
}
$result2