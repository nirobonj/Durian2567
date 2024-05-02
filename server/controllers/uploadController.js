const uploadService = require("../services/uploadService");

const uploadFile = async (req, res) => {
  // console.log(req.file);
  // console.log(req.body);
  if (!req.file) {
    return res.status(400).send("No file uploaded.");
  }

  try {
    const result = await uploadService.uploadFile(req.file.originalname, req.body.user_id, req.body.store_name);
    res.status(200).send(result);
  } catch (error) {
    console.error("Error uploading file: ", error);
    res.status(500).send("Internal server error");
  }
};

module.exports = { uploadFile };
