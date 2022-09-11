const express = require("express");
const User = require("../models/user");

const authRouter = express.Router();

authRouter.post('/api/signup', async (req, res) => {
    try {
        const { name, email, profilePic } = req.body;
        let user = await User.findOne({ email })
        if (!user) {
            user = new User({
                email,
                name,
                profilePic,
            })
            user = await user.save()
        }
        res.json({user});
    } catch (e) {
        res.status(500).json({error: e.message})
    }
}) 

module.exports = authRouter;