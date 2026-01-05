.PHONY= update build

all: update build

js: update-js build-js

update:
	wasm32-wasi-cabal update

repl: update
	wasm32-wasi-cabal repl miso-aeson -finteractive --repl-options='-fghci-browser -fghci-browser-port=8080'

build:
	wasm32-wasi-cabal build 

serve:
	http-server public

clean:
	rm -rf dist-newstyle public

update-js:
	cabal update --with-ghc=javascript-unknown-ghcjs-ghc --with-hc-pkg=javascript-unknown-ghcjs-ghc-pkg

build-js:
	cabal build --with-ghc=javascript-unknown-ghcjs-ghc --with-hc-pkg=javascript-unknown-ghcjs-ghc-pkg
