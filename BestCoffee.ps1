# 飲めるか判定
function CanDrink([Int64]$c, [Int64]$t, [Int64]$day)
{
    if ($c -eq 0) { return $false }
    if ($t -lt $day) { return $false }
    return $true
}

# 飲めるコーヒーのある最後の日は？
function WhenLastDayCanDrink([Array]$ctsAry)
{
    [Int64]$result = 0
    foreach ($item in $ctsAry)
    {
        if ($item[0] -eq 0) { continue }
        $result = [Math]::Max($item[1], $result)
    }
    return $result
}

# 指定した満足度より高いコーヒーが飲める最後の日は？
function WhenLastDayBetterCoffeeCanDrink([Array]$ctsAry, [int]$s)
{
    [Int64]$result = 0
    foreach ($item in $ctsAry)
    {
        if ($item[0] -eq 0) { continue }
        if ($item[2] -eq $s) { break }
        $result = [Math]::Max($item[1], $result)
    }
    return $result
}

$file = Get-Content C:\work\B-large-practice.in
$fi = 0
$T = $file[$fi++]

for ($i = 0; $i -lt $T; $i++)
{
    [int]$N, [Int64]$K = $file[$fi++].Split(" ")  # N：種類　K：日数
    $ctsAry = @()
    for ($j = 0; $j -lt $N; $j++)
    {
        $ctsAry += ,$file[$fi++].Split(" ")  # c：数　t：賞味期限　s：満足度
    }

    if ($ctsAry.Length -ne 1) { $ctsAry = $ctsAry | sort { [Int64]$_[2] } -Descending }

    $result = 0
    [Int64]$day = $K
    :loop while ($true)
    {
        $day = [Math]::Min((WhenLastDayCanDrink $ctsAry), $day)
        if ($day -eq 0) { break loop }

        foreach ($item in $ctsAry)
        {
            if (CanDrink $item[0] $item[1] $day)
            {
                $dayBetterCoffee = WhenLastDayBetterCoffeeCanDrink $ctsAry $item[2]
                $drinkCount = [Math]::Min($day - $dayBetterCoffee, $item[0])
                $item[0] -= $drinkCount
                $result += ([int]$item[2] * $drinkCount)
                $day -= $drinkCount
                continue loop
            }
        }

        $day--
    }

    Write-Host ("Case #" + ($i + 1) + ": " + $result)
}
