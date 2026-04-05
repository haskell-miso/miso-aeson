miso-aeson <a href="http://hackage.haskell.org/package/miso-aeson">
  <img src="https://img.shields.io/hackage/v/miso-aeson.svg?style=for-the-badge" alt="Hackage">
</a> 
====================

Library to convert between `Data.Aeson (Value)` and `Miso.JSON (Value)`

```haskell
aesonToJSON :: Aeson.Value -> JSON.Value
jsonToAeson :: JSON.Value -> Aeson.Value
```

### `DerivingVia`

You can derive `To/FromJSON` instances using the `MisoAeson` data type.

```haskell
data D = D
  { a :: Char
  , b :: Double
  }
  deriving stock (Generic)
  deriving (Data.Aeson.FromJSON, Data.Aeson.ToJSON) via Generically D
  deriving (Miso.JSON.FromJSON, Miso.JSON.ToJSON) via MisoAeson D
```

### Development

Call `nix develop` to enter a shell with [GHC 9.12.2](https://haskell.org/ghc)

```bash
$ nix develop --experimental-features nix-command --extra-experimental-features flakes
```

Once in the shell, you can call `cabal run` to start the development server and view the application at http://localhost:8080

### Build (Web Assembly)

```bash
$ nix develop .#wasm --command bash -c "make"
```

### Build (JavaScript)

```bash
$ nix develop .#ghcjs --command bash -c "make js"
```

### Serve

To host the built application you can call `serve`

```bash
$ nix develop --command bash -c "make serve"
```

### Clean

```bash
$ nix develop --command bash -c "make clean"
```
