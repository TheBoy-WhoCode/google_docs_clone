const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
    name: {
        type: String,
        requried: true,
    },
    email: {
        type: String,
        requried: true,
    },
    profilePic: {
        type: String,
        requried: true,
    }
})

const User = mongoose.model("User", userSchema);
module.exports = User;