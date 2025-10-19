import ToySat.Cnf
import ToySat.String

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

namespace ToySat

/-- コメント行を無視する -/
def ignoreComment (input : Array String) : Array String :=
  input.filter (fun line => ! line.startsWith "c")

/-- DIMACSのヘッダー行から読み取れる情報 -/
structure HeaderInfo where
  /-- 変数の数 -/
  numVar : Nat
  /-- 節の数 -/
  numClause : Nat

/-- ヘッダー行をパースする。パース結果と、残りの行を返す。 -/
def parseHeader (input : Array String) : Except String (HeaderInfo × Array String) := do
  let headerLineIdx? := input.findIdx? (fun line => line.startsWith "p cnf ")
  match headerLineIdx? with
  | none => throw "No header line found"
  | some headerLineIdx =>
    let headerLine := input[headerLineIdx]!
    let inputInts := headerLine.parseInts

    if inputInts.size != 2 then
      throw "Invalid header format"
    let nVar := inputInts[0]!
    let nClause := inputInts[1]!
    let remainingLines := input.zipIdx
      |>.filter (fun (_line, idx) => idx != headerLineIdx)
      |>.map (fun (line, _idx) => line)
    return ({ numVar := nVar.toNat, numClause := nClause.toNat }, remainingLines)

/-- DIMACS CNF の本体部分をパースする -/
def parseBody (input : Array String) : Except String (Array (Array Int) × Array String) :=
  let inputInts := input.map String.parseInts
  -- let _ := inputInts
  sorry

/-- 整数からリテラルを生成する -/
def Lit.ofInt (n : Int) : Lit Nat :=
  if n > 0 then
    { var := n.toNat, polarity := true }
  else
    { var := (-n).toNat, polarity := false }

/-- 整数の配列からCNFを生成する -/
def arrayToCnf (clauses : Array (Array Int)) : Cnf Nat :=
  clauses.map (fun clause => clause.map Lit.ofInt)

end ToySat
