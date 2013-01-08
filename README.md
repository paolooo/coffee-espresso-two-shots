# Coffee Espresso Two-Shots

$ npm install

## Run Test
$ npm test<br />
or
$ mocha --compilers coffee:coffee-script -R spec test/test

## Run CLI to convert file from SaSS to coffee-stylesheet
$ node js/cli.js test/module.css.coffee
or
$ node js/cli.js test/module.css.coffee --sass --debug
or
$ node js/cli.js test/module.css.coffee --debug

## Run CLI to convert file from HAML to coffee-template
$ node js/cli.js test/test.html.haml
or
$ node js/cli.js test/test.html.haml --haml --debug
or
$ node js/cli.js test/test.html.haml --debug

