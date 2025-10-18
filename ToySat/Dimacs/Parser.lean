
/-- ignore comment line -/
def ignoreComment (input : Array String) : Array String :=
  input.filter (fun line => ! line.startsWith "c")

/-- DIMACSのヘッダー行から読み取れる情報 -/
structure HeaderInfo where
  /-- 変数の数 -/
  numVar : Nat
  /-- 節の数 -/
  numClause : Nat

/-- ヘッダー行をパースする。パース結果と、残りの行を返す。
**注意**: この関数は、先頭の行にヘッダー行が来ることを期待する。 -/
def parseHeader (input : Array String) : Except String (HeaderInfo × Array String) :=
  match input with
  | ⟨[]⟩ => Except.error "Input is empty"
  | ⟨line :: rest⟩ =>
    if line.startsWith "p cnf " then
      let parts := line.splitOn " "
      if h : parts.length = 4 then
        match parts[2].toNat?, parts[3].toNat? with
        | some nVar, some nClause =>
          Except.ok ({ numVar := nVar, numClause := nClause }, rest.toArray)
        | _, _ => Except.error "Invalid numbers in header"
      else
        Except.error "Invalid header format"
    else
      Except.error "Header line must start with 'p cnf '"
