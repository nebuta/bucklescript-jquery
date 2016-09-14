# BuckleScript JQuery binding

BuckleScript binding for JQuery 3.1.

Still only covers a small part of JQuery, but hopefully this repo and npm package help others understand how to do FFI and make a npm package for BuckleScript.

## How to use

### Compile

To compile, for example, a client-side script with `src/main.ml` as an entry point. 

```shell
bsc -I src -c -bs-main src/main.ml -bs-package-include bucklescript-jquery -bs-package-name $npm_package_name -bs-package-output dist
```

### Bundle

To bundle with webpack:

```shell
webpack -p dist/main.js dist/bundle.js
```

then load `dist/bundle.js` in your HTML.

## Copyright

Copyright 2016 by Nebuta. MIT license.