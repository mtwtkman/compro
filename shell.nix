with import <nixpkgs> {};
mkShell {
  packages = [
    rustup
    ghc
    cabal-install
    haskell-language-server
    haskellPackages.ormolu
  ];
  shellHook = ''
    hs() {
      cp haskell/Template haskell/$1.hs
    }

    solve:hs() {
      pushd haskell
      runghc $1.hs
      popd
    }

    alias solve:rs="pushd rust;cargo run;popd"

  '';
}
