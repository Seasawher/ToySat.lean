open String

/-- 空白区切りで何かが書かれている文字列が与えられたときに、
その文字列の数値の部分だけを取り出して整数の配列に変換する -/
def String.parseInts (line : String) : Array Int :=
  line.splitOn (sep := " ")
    |>.filter (fun s => s != "")
    |>.map toInt?
    |>.filterMap id
    |>.toArray

#guard parseInts "1 -3 4 0" == #[1, -3, 4, 0]
#guard parseInts "  10   -20 30 " == #[10, -20, 30]
#guard parseInts "-1 2 -5" == #[-1, 2, -5]
#guard parseInts "0" == #[0]
#guard parseInts "" == #[]
#guard parseInts "abc def 123 x" == #[123]
