const express = require("express"); 
const app = express();
const parser = require('body-parser');
const databse = require("./connetctDB.js");
const router = require('./routes');

app.use(express.json({limit: '50mb'}));
app.use(express.urlencoded({limit: '50mb'}));


 app.use("/" , router );



app.listen(3000 , function(err){

});