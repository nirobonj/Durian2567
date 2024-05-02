const express = require("express");
const cors = require("cors");
require('dotenv').config()
const app = express();
const port = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Importing routes
const authRoutes = require('./routes/authRoutes');
const userRoutes = require('./routes/userRoutes');
const uploadRoutes = require('./routes/uploadRoutes');
const helloRoutes = require('./routes/helloRoutes');

// Routes
app.use("/auth", authRoutes);
app.use("/user", userRoutes);
app.use("/upload", uploadRoutes);
app.use("/hello", helloRoutes);

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send("Something broke!");
});

// Server startup
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
