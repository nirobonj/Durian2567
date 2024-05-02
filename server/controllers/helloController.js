const hello = async (req, res) => {
  res.json({ message: "Hello world!" });
};

module.exports = { hello };
