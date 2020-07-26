const databse = require("./connetctDB.js");
const express = require("express"); 
const parser = require('body-parser');
const app = express();

let db =null;
var arr = [];
app.use(express.json());
app.use(parser.urlencoded({ extended: true }));

app.get("/getHandbag" ,async(req , res ,next)=>{
  
  const [row] =  await databse.query("SELECT * FROM handbag",(err ,data)=>{
    // console.log(data);
    res.json(data);
  });
  next();
});

app.post("/postHandbag" , (req , res ,next)=>{
  console.log("hi");
  const name = req.body.name;
  const price = req.body.price;
  const image = req.body.image;
  const description = req.body.description;
  var sql = "INSERT INTO handbag(name , price , image ,description) values (? ,? ,?,? );"
  databse.query(sql , [name ,price , image,description]);
  res.json({status : "ok"});
 next();
});

app.post("/postT-shirt" , (req , res ,next)=>{
  console.log("hi");
  const name = req.body.name;
  const price = req.body.price;
  const image = req.body.image;
  const description = req.body.description;
  var sql = "INSERT INTO T_shirt(name , price , image ,description) values (? ,? ,?,? );"
  databse.query(sql , [name ,price , image,description]);
  res.json({status : "ok"});
 next();
});



app.listen(3000);