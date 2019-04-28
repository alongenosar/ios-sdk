module.exports = function(ctx) {

    var exec = require('child_process').exec;
    exec('type pod',(error, stdout, stderr) => {
        if(error) {
            console.log("\n******************************************************")
            console.log("*      SnappersSDK plugin requires CocoaPods         *")
            console.log("*       Running 'sudo gem install cocoapods'         *")
            console.log("******************************************************\n")
            exec('sudo gem install cocoapods')
        }
    })
}