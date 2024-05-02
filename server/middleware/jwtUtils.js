// const jwt = require("jsonwebtoken");

// const ACCESS_TOKEN_SECRET = process.env.ACCESS_TOKEN_SECRET;
// const REFRESH_TOKEN_SECRET = process.env.REFRESH_TOKEN_SECRET;

// const generateToken = (user, expiresIn, secret) => {
//   return jwt.sign({ name: user.name, id: user.id }, secret, {
//     expiresIn,
//     algorithm: "HS256",
//   });
// };

// const verifyToken = (token, secret, callback) => {
//   return new Promise((resolve, reject) => {
//     if (!token) return reject();
//     jwt.verify(token, secret, (err, decoded) => {
//       if (err) return reject(err);
//       resolve(decoded);
//     });
//   });
// };

// module.exports = {
//   generateToken,
//   verifyToken,
//   ACCESS_TOKEN_SECRET,
//   REFRESH_TOKEN_SECRET,
// };
const jwt = require("jsonwebtoken");

const ACCESS_TOKEN_SECRET = process.env.ACCESS_TOKEN_SECRET;
const REFRESH_TOKEN_SECRET = process.env.REFRESH_TOKEN_SECRET;

const generateToken = (user, expiresIn, secret) => {
  return jwt.sign({ name: user.name, id: user.id }, secret, {
    expiresIn,
    algorithm: "HS256",
  });
};

const verifyToken = (token, secret) => {
  console.log("a");
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
