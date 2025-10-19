
/- # DIMACS CNF フォーマット

DIMACS CNF フォーマットとは、CNF標準形の論理式をテキストで表現するためのフォーマット。

* `c` で始まる行はコメント行で、無視される
* `p cnf (数字) (数字)` で始まる行はヘッダー行
  最初の数字が変数の数で、２番目の数字が節（clause）の数を表す
* ヘッダー行以降の行は節を表し、数字が空白区切りで入力される。
  各数字はリテラルを表し、正の数字はその変数が真であることを、負の数字はその変数が偽であることを表す。
  同じ数字は同じ変数を表す。
  各節の最後には `0` が必要。
  普通は各節が１行を占めるが、長い節は複数行にまたがってもよい。
-/

-- declare_syntax_cat dimacs

-- declare_syntax_cat dimacs_header
-- syntax "p" "cnf" num num : dimacs_header

-- declare_syntax_cat dimacs_clause
-- syntax (("-" noWs)? num)+ : dimacs_clause

-- syntax dimacs_header dimacs_clause* : dimacs

-- syntax "[dimacs| " dimacs "]" : term

-- #check_failure [dimacs|
--   p cnf 3 2
--   1 -3 0
--   2 3 -1 0
-- ]
