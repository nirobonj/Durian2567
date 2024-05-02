// const express = require("express");
// const cors = require("cors");
// require('dotenv').config()
// const app = express();
// const port = process.env.PORT || 3000;

// // Middleware
// app.use(cors());
// app.use(express.json());

// // Importing routes
// const authRoutes = require('./routes/authRoutes');
// const userRoutes = require('./routes/userRoutes');
// const uploadRoutes = require('./routes/uploadRoutes');
// const helloRoutes = require('./routes/helloRoutes');

// // Routes
// app.use("/auth", authRoutes);
// app.use("/user", userRoutes);
// app.use("/upload", uploadRoutes);
// app.use("/hello", helloRoutes);

// // Error handling middleware
// app.use((err, req, res, next) => {
//   console.error(err.stack);
//   res.status(500).send("Something broke!");
// });

// // Server startup
// app.listen(port, () => {
//   console.log(`Server is running on port ${port}`);
// });
const express = require("express");
const cors = require("cors");
require('dotenv').config()
const multer = require("multer");
const path = require("path");
const fs = require("fs");
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
const uploadDirectory1 = path.join(__dirname, "uploads/1");
const uploadDirectory2 = path.join(__dirname, "uploads/2");
const uploadDirectory3 = path.join(__dirname, "uploads/3");
const uploadDirectory4 = path.join(__dirname, "uploads/4");
const uploadDirectory5 = path.join(__dirname, "uploads/5");
const uploadDirectory6 = path.join(__dirname, "uploads/6");

if (!fs.existsSync(uploadDirectory1)) {
  fs.mkdirSync(uploadDirectory1, { recursive: true });
}
if (!fs.existsSync(uploadDirectory2)) {
  fs.mkdirSync(uploadDirectory2, { recursive: true });
}
if (!fs.existsSync(uploadDirectory3)) {
  fs.mkdirSync(uploadDirectory3, { recursive: true });
}
if (!fs.existsSync(uploadDirectory4)) {
  fs.mkdirSync(uploadDirectory4, { recursive: true });
}
if (!fs.existsSync(uploadDirectory5)) {
  fs.mkdirSync(uploadDirectory5, { recursive: true });
}
if (!fs.existsSync(uploadDirectory6)) {
  fs.mkdirSync(uploadDirectory6, { recursive: true });
}

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const uploadDirectory = determineUploadDirectory(file.originalname);
    cb(null, uploadDirectory);
  },
  filename: (req, file, cb) => {
    const uploadDirectory = determineUploadDirectory(file.originalname);
    cb(null, `${file.originalname}`);
    // cb(null, `${formattedDate}.wav`);
  },
});
function determineUploadDirectory(filename) {
  const lastCharacter = filename.charAt(filename.length - 5);
  switch (lastCharacter) {
    case "1":
      return uploadDirectory1;
    case "2":
      return uploadDirectory2;
    case "3":
      return uploadDirectory3;
    case "4":
      return uploadDirectory4;
    case "5":
      return uploadDirectory5;
    case "6":
      return uploadDirectory6;
    default:
      return uploadDirectory1;
  }
}

const upload = multer({
  storage: storage,
  limits: {
    fileSize: 50 * 1024 * 1024, 
  },
});

app.post("/upload", upload.single("audio"), (req, res) => {
  if (!req.file) {
    return res.status(400).send("No file uploaded.");
  }

  const uploadedFilePath = path.join(determineUploadDirectory(req.file.filename), req.file.filename);
  console.log(req.file);

  console.log(`File uploaded: ${uploadedFilePath}`);

  res.status(200).send("File uploaded successfully");
});

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
