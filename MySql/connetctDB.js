const mysql = require("mysql");

const connectDB =  mysql.createConnection({
    host : "localhost",
    user :  "root",
    password : "",
    database : "online_shop"

});
connectDB.connect(function(err) {
   if(err){console.log("connection not successfully");}
   else{
    console.log("connection successfully");
   }
});


module.exports = connectDB;
