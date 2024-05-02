const express = require("express");
const router = express.Router();
const { jwtValidate } = require("../middleware/jwtMiddleware");
const { TestControoler } = require("../controllers/testController");


router.post("/", jwtValidate, upload.single("audio"), TestControoler);

module.exports = router;
