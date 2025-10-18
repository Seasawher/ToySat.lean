import Lake
open Lake DSL

package "ToySat" where
  version := v!"0.1.0"
  leanOptions := #[
    ⟨`linter.missingDocs, true⟩
  ]

@[default_target]
lean_lib «ToySat» where
  -- add library configuration options here
  globs := #[.submodules `ToySat]
