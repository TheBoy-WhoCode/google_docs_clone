const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
const cors = require('cors');
const http = require('http')

const dcoumentRouter = require("./routes/document");

const PORT = process.env.PORT | 3001;

const app = express();
var server = http.createServer(app)
var io = require('socket.io')(server)

app.use(cors());
app.use(express.json())
app.use(authRouter)
app.use(dcoumentRouter)
const DB = "mongodb+srv://thejitenpatel:test1234@cluster0.j5rx77w.mongodb.net/?retryWrites=true&w=majority";

mongoose.connect(DB).then(() => {
    console.log("Database connected successfully!");
}).catch((err) => {
    console.log(err);
})

io.on('connection', (socket) => {
    socket.on('join', (documentId) => { 
        socket.join(documentId)
        console.log("Joined!");
    })
})

server.listen(PORT, "0.0.0.0", () => {
    console.log(`Connected at port ${PORT}`);
})