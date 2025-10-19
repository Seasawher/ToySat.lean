open Array

variable {α : Type}


/-- 配列を特定の区切りでグループ化する。
区切りが見つかるまで要素を拾っていき、区切り要素が末尾に入っているような配列にまとめる。-/
def Array.groupBy (arr : Array α) (sep : α → Bool) : Array (Array α) := Id.run do
  let mut result : Array (Array α) := #[]
  let mut currentGroup : Array α := #[]
  for elem in arr do
    if sep elem then
      currentGroup := currentGroup.push elem
      result := result.push currentGroup
      currentGroup := #[]
    else
      currentGroup := currentGroup.push elem
  if currentGroup.size > 0 then
    result := result.push currentGroup
  return result

#guard #[1, 2, 3, 4, 5, 6, 7].groupBy (fun x => x % 3 == 0) = #[#[1, 2, 3], #[4, 5, 6], #[7]]
#eval #[#[1, 2], #[3, 0]].groupBy (fun x => x[x.size - 1]! = 0)
