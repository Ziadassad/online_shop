const express = require("express"); 
const router = express.Router();
const databse = require("./connetctDB.js");


router.get("/getHandbag" ,async(req , res ,next)=>{
    
  databse.query("SELECT * FROM handbag;",(err , row)=>{
        //console.log(row);
      res.json(row);
  });  

});

router.get("/getT-shirt" ,async(req , res ,next)=>{

    databse.query("SELECT * FROM t_shirt;",(err , row)=>{
      res.json(row);
    });  

});

router.get("/getaccount" ,async(req , res ,next)=>{

  databse.query("SELECT * FROM account;",(err , row)=>{
      res.json(row);
  });  
  // next();
});

router.post("/postaccount" , async (req , res, next)=>{
  const body = await req.body;
  const name = body.name;
  const email = body.email;
  const password = body.password;
  const image = body.image;
  var sql = "INSERT INTO account (name ,email, password ,image) values(? ,? ,?,?)"
  databse.query(sql , [name , email , password, image]);
  res.json({status : "ok"});
  next();
});  
  
router.post("/postHandbag" ,async (req , res ,next)=>{
  
    const body = await req.body;
    const name = body.name;
    const price = body.price;
    const image = body.image;
    const description = req.body.description;
    var sql = "INSERT INTO handbag(name , price , image ,description) values (? ,? ,?,? );"
    databse.query(sql , [ name ,price , image, description]);
    res.json({status : "ok"});
   next();
  });
  
router.post("/postT-shirt" , (req , res ,next)=>{
    console.log("hi");
      const name = req.body.name;
     const price = req.body.price;
     const image = req.body.image;
     const description = req.body.description;
    console.log(name);
     var sql = "INSERT INTO t_shirt(name , price , image ,description) values (? ,? ,?,? );"
     databse.query(sql , [name ,price , image,description]);
    res.json({status : "ok"});
   next();
  });
  
module.exports = router;  