var settings = {
	get: function(name) {
		var q = localStorage.getItem(name);
		if (q=="true") {
			return true;
		} else if (q=="false") {
			return false;
		} else {
			return q;
		}
	},
	set: function(name, value) {
		return localStorage.setItem(name, value);
	},
	saveAll: function(auth) {
		localStorage.setItem('check_minimize', ($('#minimize').is(":checked")?"true":"false"));
		localStorage.setItem('check_remember', ($('#remember').is(":checked")?"true":"false"));
		if (auth != undefined) {
			localStorage.setItem('netid', auth);
		}
	},
	loadAll: function() {
		$('#netid').val(localStorage.getItem('netid'));
		$('#minimize').attr('checked', (localStorage.getItem('check_minimize')=="true"?true:false));
		$('#remember').attr('checked', (localStorage.getItem('check_remember')=="true"?true:false));
	}
}
var appState = {
	INACTIVE: 0,
	CONNECTING: 1,
	AUTHFAIL: 2,
	OFFLINE: 3,
	ONLINE: 4,
	status: 0,
	change: function(num) {
		if (num == 4) {
			//ahentges
			tray.icon = !settings.get('q')?"resource/icon.png":"resource/icon-alt.png";
		} else {
			tray.icon = !settings.get('q')?"resource/icon-inactive.png":"resource/icon-alt-inactive.png";
		}
		if (num == 4) {
			tray.tooltip = "Connected";
			var menu = new gui.Menu();
			menu.append(new gui.MenuItem({label: "Status: Connected", enabled:false}));
			menu.append(new gui.MenuItem({type: 'separator'}));
			menu.append(new gui.MenuItem(
				{
					type:'normal',
					label:'Show interface...',
					click: function() {
						win.show();
						win.focus();
						winVisible=true
					}
				}
			));
			tray.menu = menu;
		}
		if (num == 3) {
			tray.tooltip = "Offline";
			var menu = new gui.Menu();
			menu.append(new gui.MenuItem({label: "Status: Offline", enabled:false}));
			menu.append(new gui.MenuItem({type: 'separator'}));
			menu.append(new gui.MenuItem(
				{
					type:'normal',
					label:'Show interface...',
					click: function() {
						win.show();
						win.focus();
						winVisible=true
					}
				}
			));
			tray.menu = menu;
		}
		if (num == 2) {
			tray.tooltip = "Authentication Failure";
			var menu = new gui.Menu();
			menu.append(new gui.MenuItem({label: "Status: Authentication Failure", enabled:false}));
			menu.append(new gui.MenuItem({type: 'separator'}));
			menu.append(new gui.MenuItem(
				{
					type:'normal',
					label:'Show interface...',
					click: function() {
						win.show();
						win.focus();
						winVisible=true
					}
				}
			));
			tray.menu = menu;
		}
		if (num == 1) {
			tray.tooltip = "Connecting...";
			var menu = new gui.Menu();
			menu.append(new gui.MenuItem({label: "Status: Connecting...", enabled:false}));
			menu.append(new gui.MenuItem({type: 'separator'}));
			menu.append(new gui.MenuItem(
				{
					type:'normal',
					label:'Show interface...',
					click: function() {
						win.show();
						win.focus();
						winVisible=true
					}
				}
			));
			tray.menu = menu;
		}
		if (num == 0) {
			tray.tooltip = "Inactive";
			var menu = new gui.Menu();
			menu.append(new gui.MenuItem({label: "Status: Inactive", enabled:false}));
			menu.append(new gui.MenuItem({type: 'separator'}));
			menu.append(new gui.MenuItem(
				{
					type:'normal',
					label:'Show interface...',
					click: function() {
						win.show();
						win.focus()}
					}));
			tray
			.
			m
		enu = menu;
		}
		appState.status = num;
	}
}
function timeSince(data) {

    var seconds = Math.floor((new Date().getTime() - data) / 1000);

    var interval = Math.floor(seconds / 31536000);

    interval = Math.floor(seconds / 86400);
    if (interval >= 1) {
        return interval + " day"+(interval>1?"s":"");
    }
    interval = Math.floor(seconds / 3600);
    if (interval >= 1) {
        return interval + " hour"+(interval>1?"s":"");
    }
    interval = Math.floor(seconds / 60);
    if (interval >= 1) {
        return interval + " minute"+(interval>1?"s":"");
    }
    return Math.floor(seconds) + " second"+(seconds>1?"s":"");
}