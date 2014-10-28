var sdksocialize = require('it.scosft.sdksocialize');

sdksocialize.init({
    "socializeKey" : "SOCIALIZE-KEY",
    "socializeSecret" :"SOCIALIZE-SECRET",
    "twitterConsumerKey" :"TWITTER-CONSUMER",
    "twitterConsumerSecret":"TWITTER-CONSUMER-SECRET",
    "pinterestApp":"PINTEREST-KEY",
    "facebokAppID":"FACEBOOK-APP-ID"
});

function doClick(e) {
    alert($.label.text);
}

var testView = Ti.UI.createView({
    width:Ti.UI.FILL,
    height:250,
    backgroundColor:'blue',
    top:50
});

var bar3 = sdksocialize.createBarView({
   height:44,
   width:Ti.UI.FILL,
   image:"http://vangle.cdnscsoft.com/image/cache/data/borse/buste/borsa-in-pelle-fiorita-390x390.jpg",
   url:"http://shop.vangle.it/store",
   name:"Vangle",
   description:"Ciao ciaoc iao ciao caio",
   bgColor:'green',
   alpha:0.8,
});
testView.add(bar3);

$.index.add(testView);


var bar2 = sdksocialize.createLikeView({
   bottom:20,
   height:100,
   width:200,
   url:"http://sd.keepcalm-o-matic.co.uk/i/keep-calm-and-fanculo-panzone-25.png",
   image:"http://sd.keepcalm-o-matic.co.uk/i/keep-calm-and-fanculo-panzone-25.png",
   name:"Panzone",
   backgroundColor:"black"
});
$.index.add(bar2);

$.index.open();


Ti.App.addEventListener('resumed', function (e) {
    // Ti.Platform.openURL('fb827787213920034://page/confirm?id=5');

    Ti.App.launchURL = '';
    cmd = Ti.App.getArguments();
    if ( cmd.url ) {
        if ( cmd.url != Ti.App.pauseURL ) {
            Ti.App.launchURL = cmd.url;
            Ti.API.info( 'Resumed with url = ' + Ti.App.launchURL );
           
        }
    }
   
    Ti.API.info('URL DA APP:'+Ti.App.launchURL);
    sdksocialize.handleOpenURL(Ti.App.launchURL);
});