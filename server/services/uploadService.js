const path = require("path");
const pool = require("../configs/databaseConfig");

const uploadFile = async (file, user_id, store_name) => {
  // console.log(file);
  if (!file) throw new Error("No file uploaded.");

  let levels = file.charAt(file.length - 5);
  // const uploadedFilePath = path.join(
  //   __dirname,
  //   `../uploads/${file.originalname}`
  // );

  try {
    const client = await pool.connect();
    await client.query(
      "INSERT INTO public.sound_record(user_id, filename, levels, store_name) VALUES ($1, $2,$3,$4)",
      [user_id, file, levels, store_name]
    );
    client.release();
    console.log("Data inserted successfully");
    return "File uploaded and data inserted successfully";
  } catch (err) {
    console.error("Error inserting data: ", err);
    throw new Error("Internal server error");
  }
};

module.exports = { uploadFile };
