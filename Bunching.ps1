$file = Get-Content C:\work\A-large-practice.in
$fi = 0
$T = $file[$fi++]

for ($i = 0; $i -lt $T; $i++)
{
    [int]$N, [Int64]$K = $file[$fi++].Split(" ")  # N：個数　K：鳴らした数

    $bit = [Convert]::ToString($K, 2)

    if ($N -lt $bit.Length) { $bit = $bit.Substring($bit.Length - $N, $N) }
    elseif ($bit.Length -lt $N) { $bit = 0 }  # ちょっと適当だけど．．．

    $on = $true
    for ($j = 0; $j -lt $bit.Length; $j++)
    {
        if ($bit[$j] -eq "0") { $on = $false; break }
    }

    if ($on) { Write-Host ("Case #" + ($i + 1) + ": ON") }
    else { Write-Host ("Case #" + ($i + 1) + ": OFF") }
}