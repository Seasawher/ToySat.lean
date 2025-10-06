
/--
CNFの節。各 `v : Option Bool` は変数が現れるかどうかと、極性を表す。
* `none` は変数が現れないことを表す
* `some true` は肯定的に現れることを表す
* `some false` は否定的に現れることを表す

引数の `n` は変数の数を表す。
-/
def Clause (n : Nat) := Vector (Option Bool) n

/-- n 変数で m 個の節からなる CNF -/
def Cnf (n m : Nat) := Vector (Clause n) m
