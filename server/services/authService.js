// const jwtUtils = require("../utils/jwtUtils");
// const userService = require("./userService");
// const crypto = require("crypto");
// const pool = require("../configs/databaseConfig");

// const comparePassword = (password, hashedPassword) => {
//   const hashedInputPassword = crypto
//     .createHash("sha512")
//     .update(password)
//     .digest("hex");
//   return hashedInputPassword === hashedPassword;
// };

// const authenticateUser = async (username, password) => {
  
//   const client = await pool.connect();
//   try {
//     const result = await client.query(
//       "SELECT passwords FROM users WHERE username = $1",
//       [username]
//     );
//     if (result.rows.length === 0) {
//       // Username not found
//       return false;
//     }

//     const storedPassword = result.rows[0].passwords;
//     // console.log(storedPassword);
//     // console.log(password);
//     return comparePassword(password, storedPassword);
//   } finally {
//     client.release();
//   }
// };

// const login = async (user) => {
//   // console.log(user);
//   if (!user) throw new Error("User not found");
//   console.log(user);
//   const isAuthenticated = await authenticateUser(user.username, user.passwords);
//   // console.log(isAuthenticated);
//   if (!isAuthenticated) throw new Error("Invalid username or password");

//   const accessToken = jwtUtils.generateToken(
//     // user,
//     { username: user.username, id: user.id },
//     "0",
//     jwtUtils.ACCESS_TOKEN_SECRET
//   );

//   const refreshToken = jwtUtils.generateToken(
//     // user,
//     { username: user.username, id: user.id },
//     "0",
//     jwtUtils.REFRESH_TOKEN_SECRET
//   );

//   await userService.updateRefreshToken(user.id, refreshToken);
//   console.log("accessToken : "+accessToken);
//   console.log("refreshToken : "+refreshToken);

//   return { access_token: accessToken, refresh_token: refreshToken };
// };

// module.exports = { login };
const jwtUtils = require("../utils/jwtUtils");
const userService = require("./userService");
const crypto = require("crypto");
const pool = require("../configs/databaseConfig");



const comparePassword = (password, hashedPassword) => {
  const hashedInputPassword = crypto
    .createHash("sha512")
    .update(password)
    .digest("hex");
  return hashedInputPassword === hashedPassword;
};

const authenticateUser = async (username, password) => {
  const client = await pool.connect();
  try {
    const result = await client.query(
      "SELECT passwords FROM users WHERE username = $1",
      [username]
    );
    if (result.rows.length === 0) {
      // Username not found
      return false;
    }

    const storedPassword = result.rows[0].passwords;
    const passwordValid = comparePassword(password, storedPassword);

    if (!passwordValid) {
      return false; // Password not valid
    }

    return true;
  } finally {
    client.release();
  }
};

const login = async (user) => {
  if (!user) throw new Error("User not found");

  const accessToken = jwtUtils.generateToken(
    { username: user.username, id: user.id },
    "5d", // Set expiration time as needed
    jwtUtils.ACCESS_TOKEN_SECRET
  );

  const refreshToken = jwtUtils.generateToken(
    { username: user.username, id: user.id },
    "1d", // Set expiration time as needed
    jwtUtils.REFRESH_TOKEN_SECRET
  );

  await userService.updateRefreshToken(user.id, refreshToken);
  console.log("accessToken : " + accessToken);
  console.log("refreshToken : " + refreshToken);
  return { access_token: accessToken, refresh_token: refreshToken };
};

const verifyTokenAndRespond = async (req, res) => {
  try {
    const token = req.headers.authorization.split(" ")[1]; // Extract token from Authorization header
    const decoded = await jwtUtils.verifyToken(token, jwtUtils.ACCESS_TOKEN_SECRET); // Verify token
    console.log("token: "+token);
    // If token is valid, respond with "hello world"
    res.send("hello world");
  } catch (error) {
    // If token is invalid or expired, respond with appropriate error
    res.status(401).send("Unauthorized");
  }
};


module.exports = { login, verifyTokenAndRespond };
