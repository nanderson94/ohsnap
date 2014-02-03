var dns 		= require('dns'),
	fs 			= require('fs'),
	zombie 		= require('zombie'),
	requesta 	= require('request');

// GMU's UAC page uses a self-signed certificate

// TO-DO: Include expected server certificate?

process.env['NODE_TLS_REJECT_UNAUTHORIZED'] = '0';

// Not quite ready for this one yet!
var mobileUA = "Mozilla/5.0 (Linux; Android 4.2.1; en-us; Nexus 5 Build/JOP40D"
	+") AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.166 Mobile Saf"
	+"ari/535.19"

// As the function implies, logs into the UAC page
exports.login = function(username, password, options, callback) {
	if (username.length<1) {
		callback("Missing Username");
		return;
	}
	if (password.length<1) {
		callback("Missing Password");
		return;
	}
	var options = {
		url: 	options['url'] 		|| "https://uac.gmu.edu/",
		ua: 	options['ua']  		|| mobileUA,
		realm: 	options['realm']	|| "students"
	};
	console.log(options["realm"]);
	console.log("asdf");
	var browser = new zombie();
//	browser.userAgent = options['ua'];
	browser.on('error',function (err){
	//    console.log(err.stack)
	});
	browser.visit(options['url']+options['realm'], function() {
		console.log(browser.location.pathname);
		if (browser.location.pathname == "/dana/home/infranet.cgi") {
			// Already logged in
			callback("Logged In");
		} else {
			browser.
				fill('username', username).
				fill('password', password).
				pressButton("btnSubmit", function() {
					if (browser.location.search == "?p=failed") {
						callback("Invalid Login");
						return;
					} else {
						browser.document.querySelector('[name="frmGrab"]').submit();
						callback("Success");
					}
				});
		}
	})
}
exports.checkNetwork = function(callback) {
	requesta.get({url:'http://google.com',followRedirect:false}, function(error, res, body) {
		if (error) {
			// General Connection Issue
			callback(0);
		} else if (body.length < 15) {
			// UAC Redirect

			// Are we actually connecting to the UAC?
			// requesta.get({url:'https://uac.gmu.edu'}, function(error) {
			// 	// Uhh, I don't know how to test this, maybe go to Starbucks?
			// })
			callback(1);
		} else {
			// All Good
			callback(2);
		}
	});
}