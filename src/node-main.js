var dns 		= require('dns'),
	fs 			= require('fs'),
	zombie 		= require('zombie'),
	cookies 	= "";
	zombie.loadCSS = false;

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
		url: 					options['url'] 					|| "https://uac.gmu.edu/",
		ua: 					options['ua']  					|| "Mozilla/5.0 (Linux; Android 4.2.1; en-us; Nexus 5 Build/JOP40D"
																	+") AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.16"
																	+"6 Mobile Safari/535.19",
		realm: 					options['realm']				|| "students",
		usernameselector: 		options['usernameselector'] 	|| "#username",
		passwordselector: 		options['passwordselector']		|| "#password",
		submitselector: 		options['submitselector']		|| ".confirm",
		checkselector: 			options['checkselector'] 		|| '[name="frmGrab"]'
	};

	var browser = new zombie();

	if (options['ua'].length > 0) {
		browser.userAgent = options['ua'];
	}
	console.log(cookies);
	if (cookies.length>1) {
		browser.loadCookies(cookies);
	}
	browser.on('error',function (err){
	//    console.log(err.stack)
	});
	browser.visit(options['url']+options['realm'], function() {
		console.log(browser.location.pathname);
		if (browser.location.pathname == "/dana/home/infranet.cgi") {
			callback("Logged In");
		} else {
			// This turns the "Sign in" link into 
			browser.document.querySelector(options['submitselector']).parentNode.innerHTML = 
				browser.document.querySelector(options['submitselector']).parentNode.innerHTML.
					replace('<a', '<input type="submit"').replace('</a>', '');
			browser.
				fill(options['usernameselector'], username).
				fill(options['passwordselector'], password).
				pressButton(options['submitselector'], function() {
					if (browser.location.search == "?p=failed") {
						callback("Invalid Login");
						return;
					} else if (browser.location.pathname == "") {
						callback("Invalid Login");
					} else {
						browser.document.querySelector(options['checkselector']).submit();
						callback("Success");
						cookies = browser.saveCookies();
					}
				});
		}
	});
}
exports.checkNetwork = function(callback) {
	// No longer DoSing Google!!
	var browser = new zombie();
	browser.loadCookies(cookies);
	browser.visit("https://uac.gmu.edu/students", function() {
		if (browser.location.pathname == "/dana/home/infranet.cgi") {
			// UAC remembers us, all good!
			callback(2);
		} else if (browser.location.pathname.indexOf("/dana-na/auth") == 0) {
			// Unauthorized
			callback(1);
		} else {
			// Don't really know what else could happen
			callback(0);
		}
	});
}