const express = require('express');
const router = express.Router();
const { login, refreshToken } = require('../controllers/authController');
const { jwtRefreshTokenValidate } = require('../middleware/jwtMiddleware');

router.post("/login", login);
router.post("/refresh", jwtRefreshTokenValidate, refreshToken);

module.exports = router;
