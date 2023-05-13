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

    hs:yuki() {
      hs "Yukicoder/$1"
    }

    solve:hs() {
      pushd haskell
      runghc $1.hs
      popd
    }

    solve:hs:yuki() {
      solve:hs "Yukicoder/$1"
    }

    alias solve:rs="pushd rust;cargo run;popd"

  '';
}
