$file = Get-Content C:\work\A-large-practice.in
$fi = 0
$T = $file[$fi++]

for ($i = 0; $i -lt $T; $i++)
{
    [int]$m, [int]$c, [int]$w = $file[$fi++].split(" ")
    $array = @()
    for ($j = 0; $j -lt $c; $j++)
    {
        $ab = $file[$fi++].split(" ")
        $array += ,$ab
    }

    for ($j = 0; $j -lt $c; $j++)
    {
        [int]$a, [int]$b = $array[-($j + 1)]
 
        switch ($w)
        {
            # カット範囲にターゲットが入ってた．
            {$_ -le $b} {$w += ($a - 1)}
            # カットしてるとこと関係ない後ろのほうにターゲット．
            {($a + $b - 1) -lt $_} { }
            # ターゲットの後ろから前にカットされた．
            default {$w -= $b}
        }
    }
    "Case #" + ($i + 1) + ": " + $w
}
