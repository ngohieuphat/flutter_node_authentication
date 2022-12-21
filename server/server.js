const express = require('express')
const app = express();
// const port = 3000
const mongoose = require("mongoose");

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

// signup route api
app.post("/signup", async (req, res) => {
  let { email, password } = req.body;
  console.log(email);
  console.log(password);
  var schema = new mongoose.Schema({ email: "string", password: "string" });
  var User = mongoose.model("User", schema);

  let user = new User({
    email,
    password,
  });
  console.log(user);

  await user.save();
  res.json({ token: "12345678911" });
  // check db for email if email say the email is already taken
  //   return res.send("Signup api route");
});

app.listen(3000, () => {
  console.log(`Example app listening on port 3000`);
})