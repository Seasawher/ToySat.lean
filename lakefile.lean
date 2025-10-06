import Lake
open Lake DSL

package "ToySat" where
  version := v!"0.1.0"

lean_lib «ToySat» where
  -- add library configuration options here

@[default_target]
lean_exe "toysat" where
  root := `Main
