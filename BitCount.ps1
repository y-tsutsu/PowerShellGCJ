$file = Get-Content C:\work\C-large-practice.in
$fi = 0
$T = $file[$fi++]

for ($i = 0; $i -lt $T; $i++)
{
    [UInt64]$N = $file[$fi++]
    $str = [Convert]::ToString($N, 2)
    $rstr = $str[($str.Length - 1)..0]

    $result = 0
    $carry = 0
    foreach ($item in $rstr)
    {
        $bit = [int]$item + $carry
        switch($bit)
        {
            {($_ % 2) -eq 0} { $result += 2; $carry = 1 }
            {($_ % 2) -eq 1} { $result += 1;}
        }
    }

    if ($carry -eq 1) { $result -= 2 }

    "Case #" + ($i + 1) + ": " + $result
}
