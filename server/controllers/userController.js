const userService = require("../services/userService");

const registerUser = async (req, res) => {
  try {
    console.log(req.body);
    await userService.registerUser(req.body);
    res.status(201).send("User registered successfully");
  } catch (error) {
    console.error("Error registering user:", error);
    res.status(500).send("Error registering user");
  }
};

module.exports = { registerUser };
