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
      hs "Yukicoder/No$1"
    }

    answer:hs:yuki() {
      vim "haskell/Yukicoder/No$1.hs"
    }

    repl:hs:yuki() {
      ghci "haskell/Yukicoder/No$1.hs"
    }

    solve:hs() {
      pushd haskell
      runghc $1.hs
      popd
    }

    solve:hs:yuki() {
      solve:hs "Yukicoder/No$1"
    }

    alias solve:rs="pushd rust;cargo run;popd"

  '';
}
