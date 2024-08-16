const pool = require('../config/db');
const jwt = require('jsonwebtoken');
const { hashPassword, validatePassword } = require('../model/UserModel');
const { checkEmail } = require('../model/UserModel');

const registerUser = async (req, res) => {
  const { username, password ,role} = req.body;
  const hashedPassword = await hashPassword(password);

if (!checkEmail(username)) {
  return res.status(400).send('Invalid email');
}

  const query = 'INSERT INTO users (username, password,role) VALUES ($1, $2, $3)';
  const values = [username, hashedPassword,role];

  try {
    await pool.query(query, values);
    res.status(201).send('User registered');
  } catch (error) {
    console.error(error);
    res.status(500).send('Server error');
  }
};

const loginUser = async (req, res) => {
  const { username, password } = req.body;

  const query = 'SELECT * FROM users WHERE username = $1';
  const values = [username];

  try {
    const result = await pool.query(query, values);
    if (result.rows.length === 0) {
      return res.status(400).json({ message: 'Invalid credentials' });
    }

    const user = result.rows[0];
    const isValid = await validatePassword(password, user.password);

    if (!isValid) {
      return res.status(400).json({ message: 'Invalid credentials' });
    }

    const token = jwt.sign({ id: user.id }, process.env.JWT_SECRET, { expiresIn: '1h' });
    res.json({
      token,
      user: {
        username: user.username,
        role: user.role,
      },
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Server error' });
  }
};

module.exports = { registerUser, loginUser };