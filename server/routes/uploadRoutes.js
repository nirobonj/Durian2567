const express = require("express");
const router = express.Router();
const { jwtValidate } = require("../middleware/jwtMiddleware");
const { uploadFile } = require("../controllers/uploadController");
const path = require("path");
const multer = require("multer");
const fs = require("fs"); // Import the fs module

const uploadDirectories = ["0", "1", "2", "3", "4", "5", "6"];

uploadDirectories.forEach((dir) => {
  const uploadDirectory = path.join(__dirname, `../uploads/${dir}`);
  if (!fs.existsSync(uploadDirectory)) {
    fs.mkdirSync(uploadDirectory, { recursive: true });
  }
});

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const uploadDirectory = determineUploadDirectory(file.originalname);
    cb(null, uploadDirectory);
  },
  filename: (req, file, cb) => {
    const uploadDirectory = determineUploadDirectory(file.originalname);
    cb(null, `${file.originalname}`);
  },
});

function determineUploadDirectory(filename) {
  const lastCharacter = filename.charAt(filename.length - 5);
  const uploadIndex = parseInt(lastCharacter);
  const selectedDirectory =
    uploadIndex >= 1 && uploadIndex <= 6 ? uploadIndex : 0;
  return path.resolve(__dirname, `../uploads/${selectedDirectory}`);
}

const upload = multer({
  storage: storage,
  limits: {
    fileSize: 50 * 1024 * 1024, // 50 MB
  },
});
// router.post("/", jwtValidate, upload.single("audio"), uploadFile);
router.post("/", upload.single("audio"), (uploadFile));
// router.post("/", upload.single("audio"), (req,res)=>{
//   res.send(req.file.filename);
//   console.log(req.body);
// });

module.exports = router;
