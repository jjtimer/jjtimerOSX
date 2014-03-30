var Event = Event();
var Timer = Timer(Event, App);
var currSession = new Session();
Event.on('timer/running', function() { App.set_title(Timer.getCurrent()); } );
Event.on('timer/stopped', function() { currSession.add({time: 0}); });