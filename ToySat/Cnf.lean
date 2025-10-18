
/-- リテラル。変数と変数の否定。-/
structure Lit (α : Type) where
  /-- 変数名 -/
  var : α
  /-- 極性。`true` なら肯定で、`false` なら否定 -/
  polarity : Bool

/-- CNFの節 -/
def Clause (α : Type) := List (Lit α)

/-- CNF -/
def Cnf (α : Type) := List (Clause α)
