const express = require("express");
const mongoose = require("mongoose");

const PORT = process.env.PORT | 3001;

const app = express();

const DB = "mongodb+srv://thejitenpatel:test1234@cluster0.j5rx77w.mongodb.net/?retryWrites=true&w=majority";




mongoose.connect(DB).then(() => {
    console.log("Database connected successfully!");
}).catch((err) => {
    console.log(err);
})

app.listen(PORT, "0.0.0.0", () => {
    console.log(`Connected at port ${PORT}`);
})