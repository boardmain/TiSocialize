# Titanium Socialize SDK Module

## Description

With this module you can use the [Socialize SDK](http://getsocialize.com) To you IOS App

## Quick Start
- Clone this Repository
- Copy the content of the folder "AddToYourFrameWorkFolder" to a folder in your system and put the path to the file iphone/module.xcconfig and replace this TITANIUM_THIRDPARTY = "/Users/francesco/Library/Application\ Support/Titanium/thirdparty" with your path
- Copy the content of the folder "AddToYourAppAssetsFolder" in your assets folder (for alloy project) or Resource folder (for standard project)
- build the module with build.py script and add it to titanium	

## TODO
Fix Pinterset Share
Fix OpenApp from Socialize View

## RESULTS

you can try  the result with the  [Vangle APP](https://itunes.apple.com/it/app/vangle-shop/id746300889?mt=8&uo=4) and here se the [Socialize social Page](http://besoci.al/yQgTT)

## DONATIONS

If you like my work and help me to mantain updated this module you can donate with paypal

<a href="https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=samuele%2ecoppede%40gmail%2ecom&lc=IT&item_name=Titanium%20SDK%20Socialize%20Module&no_note=0&currency_code=EUR&bn=PP%2dDonationsBF%3abtn_donateCC_LG%2egif%3aNonHostedGuest"><img src="https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif" alt="[paypal]" /></a>


## Community Driven

I encourage everyone to send Pull Requests - keeping this module flying with new features.


## Author

**Samuele Coppede'**  
web: http://www.scsoft.it  
email: samuele@scsoft.it
twitter: @samuele81



# Example 

```javascript

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

```


##API


```objective-c
//create Socialize Bar
sdksocialize.createBarView({
	width:'',
	height:'',
	url:URL,
	image:IMAGEURL,
	name:NAME,
	description:DESCRIPTION,
	bgColor:BGCOLOR,
	alpha:ALPHA
});



//Create Like View
sdksocialize.createLikeView({
	width:'',
	height:'',
	url:URL,
	image:IMAGEURL,
	name:NAME,
	description:DESCRIPTION,
	bgColor:BGCOLOR,
	alpha:ALPHA	
});

```


## License


    Copyright (c) 2010-2014 Samuele Coppede

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.
    


------------------------------
