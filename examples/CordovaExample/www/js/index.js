

var app = {
    // Application Constructor
    initialize: function() {
        document.addEventListener('deviceready', this.onDeviceReady.bind(this), false);
    },
    onDeviceReady: function() {
        document.getElementById('identifyButton').addEventListener('click',() => {
            document.getElementById("loadingSpinner").style.display = 'block';
            SnappersSDK.identify("SNAPPERS TOKEN","SNAPPERS SECRET",error => {
            document.getElementById("loadingSpinner").style.display = 'none';
            if(error) alert(error)})
        })
        document.getElementById('presentMapButton').addEventListener('click',() => {
            document.getElementById("loadingSpinner").style.display = 'block';
            SnappersSDK.presentView("map",(error)=> {
                 document.getElementById("loadingSpinner").style.display = 'none';
                if(error) alert(error)})
        })
        document.getElementById('presentListButton').addEventListener('click',() => {
             document.getElementById("loadingSpinner").style.display = 'block';
            SnappersSDK.presentView("list",(error)=> {
               document.getElementById("loadingSpinner").style.display = 'none';
            if(error) alert(error)})
        })
        document.getElementById('facebookButton').addEventListener('click',() => {
            document.getElementById("loadingSpinner").style.display = 'block';
            SnappersSDK.socialLogin("facebook",(error)=> {
                 document.getElementById("loadingSpinner").style.display = 'none';
                if(error) alert(error)})
        })
        document.getElementById('twitterButton').addEventListener('click',() => {
            document.getElementById("loadingSpinner").style.display = 'block';
            SnappersSDK.socialLogin("twitter",(error)=> {
                document.getElementById("loadingSpinner").style.display = 'none';
                if(error) alert(error)})
        })
        document.getElementById('logoutButton').addEventListener('click',() => {
            document.getElementById("loadingSpinner").style.display = 'block';
            SnappersSDK.logout((error)=> {
                document.getElementById("loadingSpinner").style.display = 'none';
               if(error) alert(error)})
        })
        document.getElementById('testNotificationButton').addEventListener('click',() => {
            document.getElementById("loadingSpinner").style.display = 'block';
            SnappersSDK.requestTestInvitation("-LZnIwLcy9zeiVGJaB7t",5.0,(error)=> {
               document.getElementById("loadingSpinner").style.display = 'none';
              if(error) alert(error)})
        })
        document.getElementById('registeredUserLoginButton').addEventListener('click',() => {
            document.getElementById("loadingSpinner").style.display = 'block';
            SnappersSDK.registeredUserLogin("Alon Genosar","ID:12345","null",(error)=> {
                 document.getElementById("loadingSpinner").style.display = 'none';
                if(error) alert(error)})
        })
    }
};
app.initialize();
