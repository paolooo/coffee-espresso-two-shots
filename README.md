# Coffee Espresso Two-Shots

$ npm install

## Run Test
$ npm test<br />
or<br />
$ mocha --compilers coffee:coffee-script -R spec test/test<br />

## Run CLI to convert file from SaSS to coffee-stylesheet
$ node js/cli.js test/module.css.coffee<br />
or<br />
$ node js/cli.js test/module.css.coffee --sass --debug<br />
or<br />
$ node js/cli.js test/module.css.coffee --debug<br />

## Run CLI to convert file from HAML to coffee-template
$ node js/cli.js test/test.html.haml<br />
or<br />
$ node js/cli.js test/test.html.haml --haml --debug<br />
or<br />
$ node js/cli.js test/test.html.haml --debug<br />

