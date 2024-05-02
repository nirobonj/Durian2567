const pool = require("../configs/databaseConfig");
const crypto = require('crypto');

const registerUser = async ({
  username,
  passwords,
}) => {
  function hashPassword(password) {
    const hashedPassword = crypto.createHash('sha512').update(password).digest('hex');
    return {
      hashedPassword: hashedPassword
  };
  
  }
  const { hashedPassword } = hashPassword(passwords);
  const client = await pool.connect();
  await client.query(
    `INSERT INTO users (username, passwords) 
     VALUES ($1, $2)`,
     [username, hashedPassword]
  );
  client.release();
};


const findUserByName = async (name) => {

};

const findUserByRefreshToken = async (refreshToken) => {
  // Implement user retrieval by refresh token from the database
};

const updateRefreshToken = async (userId, refreshToken) => {
  // Implement update of refresh token in the database for the specified user
};

module.exports = {
  registerUser,
  findUserByName,
  findUserByRefreshToken,
  updateRefreshToken,
};
