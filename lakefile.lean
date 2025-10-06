import Lake
open Lake DSL

package "ToySat" where
  version := v!"0.1.0"

lean_lib «ToySat» where
  -- add library configuration options here
  globs := #[.submodules `ToySat]

@[default_target]
lean_exe "toysat" where
  root := `Main
