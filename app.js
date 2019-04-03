const express = require('express'),
	app = express(),
	tl = require('./')

// var api = express.Router();
var expressValidator = require('express-validator');
app.use(expressValidator());
app.engine('tl', tl)
app.set('views', './views') // specify the views directory
app.set('view engine', 'tl') // register the template engine

// var regex = new RegExp('^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

// var mediumRegex = new RegExp("^(((?=.*[a-z])(?=.*[A-Z]))|((?=.*[a-z])(?=.*[0-9]))|((?=.*[A-Z])(?=.*[0-9])))(?=.{6,})");

app.get('/', function(req, res) {
	res.render('index', {
		name: ['Nila', 'Rifka', 'Yas'],
		head: 'Kelompok 9'
	})
})

app.get('/:name', function(req, res) {
	res.render('index', {
		name: req.params.name,
		head: 'Kelompok 9'
	})
})

app.get('/:name/:email', function(req, res) {
	res.render('index', {
		name: req.params.name,
		email: req.params.email,
		head: 'Kelompok 9'
	})
})
// ^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$

app.get('/:name/:email/:password', function(req, res) {
	//validation
	const regex = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}/gm;
	var pass = req.params.password;
	let m;
	var errors = 1;
	while ((m = regex.exec(pass)) !== null) {
	    // This is necessary to avoid infinite loops with zero-width matches
	    if (m.index === regex.lastIndex) {
	        regex.lastIndex++;
	    }	    
	    // The result can be accessed through the `m`-variable.
	    m.forEach((match, groupIndex) => {
	        console.log(`Found match, group ${groupIndex}: ${match}`);
	       	errors = 0;

	    });
	}
	if(!errors)
	{
	res.render('index', {
		name: req.params.name,
		email: req.params.email,
		password: pass,
		head: 'Kelompok 9'
	})
	}else{
		res.send('Sorry, this is an invalid URL');
	}
})

app.get(/^\/(api|rest)\/.+$/, function( req, res, next ) {
    res.send( "My route worked!" );
} );

// app.get('/:apa(/^\/[A-Za-z]+\/.$/)', function( req, res, next ) {
//     res.send( "My route worked!" );
// } );

// app.get(/^\/(a|b)\/(.+)/, function (req, res, next) {
//   res.write(req.params[0]); //This has "discussion" or "page"
//   res.write(req.params[1]); //This has the slug
//   res.end();
// });

app.get('*' , function(req, res){
	res.send('Sorry, this is an invalid URL');
});

app.listen(3000, () => console.log('Example app listening on port 3000!'))