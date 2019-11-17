const router = require("express").Router();
module.exports = router;

router.get("/ping",(req,res,nect)=>{
  try{
    res.json(true)
  }catch(err){
    next(err)
  }
})

router.use("/blocks", require("./blocks"));

router.use((req, res, next) => {
  const error = new Error("Not Found");
  error.status = 404;
  next(error);
});
