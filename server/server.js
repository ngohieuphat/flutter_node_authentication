const express = require('express')
const app = express();
// const port = 3000
const mongoose = require("mongoose");
var jwt = require("jsonwebtoken");




async function connectDB(){
  await mongoose.connect("mongodb+srv://admin:admin@cluster0.ygk7d.mongodb.net/?retryWrites=true&w=majority" ,  { useUnifiedTopology: true, useNewUrlParser: true });
  console.log('db connected');
}
connectDB();
// tra json
app.use(express.json({extended:false}));
app.get('/', (req, res) => {
  res.send('Hello World!')
})
//model 
var schema = new mongoose.Schema({ email: "string", password: "string" });
  var User = mongoose.model("User", schema);
// signup route api
app.post("/signup", async (req, res) => {
  let { email, password } = req.body;
  console.log(email);
  console.log(password);
  let user = await User.findOne({email});
  if(user){
    return res.json({msg: "email already taken"});
  }

   user = new User({
    email,
    password,
  });
  console.log(user);

  await user.save();
  var token = jwt.sign({id:user.id }, "password");

  res.json({ token: token});
  // check db for email if email say the email is already taken
  //   return res.send("Signup api route");
});
// login route api
app.post("/login", async (req, res) => {
  let { email, password } = req.body;
  console.log(email);
  let user = await User.findOne({email});
  console.log(user);
  if(!user){
    return res.json({msg: "no user found with that email"});
  }
  if(user.password !== password){
    return res.json({msg:"password is not correct"});
  }
  var token = jwt.sign({id:user.id }, "password");
  return res.json({ token: token });
  // check db for email if email say the email is already taken
  //   return res.send("Signup api route");
});
app.listen(3000, () => {
  console.log(`Example app listening on port 3000`);
})