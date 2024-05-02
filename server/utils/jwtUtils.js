const jwt = require("jsonwebtoken");
require('dotenv').config()

const ACCESS_TOKEN_SECRET = process.env.ACCESS_TOKEN_SECRET;
const REFRESH_TOKEN_SECRET = process.env.REFRESH_TOKEN_SECRET;

const generateToken = (user, expiresIn, secret) => {
  const accessToken = jwt.sign({ name: user.username, id: user.id }, secret, {
    expiresIn,
    algorithm: "HS256",
  });
  // console.log(accessToken);
  return accessToken;
};

const verifyToken = (token, secret) => {
  return new Promise((resolve, reject) => {
    if (!token) return reject();
    jwt.verify(token.replace("Bearer ", ""), secret, (err, decoded) => {
      if (err) return reject(err);
      resolve(decoded);
    });
  });
};

module.exports = {
  generateToken,
  verifyToken,
  ACCESS_TOKEN_SECRET,
  REFRESH_TOKEN_SECRET,
};
