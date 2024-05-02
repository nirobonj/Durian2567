const express = require("express");
const path = require("path");
const router = express.Router();
const { jwtValidate } = require("../middleware/jwtMiddleware");
const { hello } = require("../controllers/helloController");

router.get("/", jwtValidate, hello);

router.get('/index', (req, res) => {
    const indexPath = path.resolve(__dirname, '../index.html');
    res.sendFile(indexPath);
});

module.exports = router;
