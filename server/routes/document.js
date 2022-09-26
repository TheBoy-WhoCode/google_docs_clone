const express = require('express')
const Document = require('../models/document')
const dcoumentRouter = express.Router()
const auth = require("../middleware/auth")

dcoumentRouter.post('/doc/create', auth, async (req, res) => { 
    try {
        const { createdAt } = req.body
        let document = new Document({
            uid: req.user,
            title: 'Untitled Dcoument',
            createdAt, 
        })

        document = await document.save()
        res.json(document)
        
    } catch (error) {
        res.status(500).json({error: error.message})
    }
})

dcoumentRouter.get('/docs/me', auth,  async (req, res) => { 
    try {
        let documents = await Document.find({ uid: req.user })
        res.json(documents)
    } catch (error) {
        res.status(500).json({error: error.message})
    }
})

module.exports = dcoumentRouter