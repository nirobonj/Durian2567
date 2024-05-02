const authService = require('../services/authService');

const login = async (req, res) => {
  try {
    const  user  = req.body;
    console.log(user);
    const tokens = await authService.login(user);
    // console.log(tokens);
    res.json(tokens);
  } catch (error) {
    res.sendStatus(400);
  }
};

const refreshToken = async (req, res) => {
  try {
    const tokens = await authService.refreshToken(req.user);
    res.json(tokens);
  } catch (error) {
    res.sendStatus(401);
  }
};

module.exports = { login, refreshToken };
