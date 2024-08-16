const pool = require('../config/db');
const bcrypt = require('bcrypt');

const createUserTable = async () => {
  const query = `
    CREATE TABLE IF NOT EXISTS users (
      id SERIAL PRIMARY KEY,
      username VARCHAR(50) UNIQUE NOT NULL,
      password VARCHAR(255) NOT NULL,
      role VARCHAR(50) NOT NULL
    );
  `;
  await pool.query(query);
};

const checkEmail = function (email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
  };

const hashPassword = async (password) => {
    const salt = await bcrypt.genSalt(10);
    return await bcrypt.hash(password, salt);
  };


  const validatePassword = async (inputPassword, storedPassword) => {
    try {
      return await bcrypt.compare(inputPassword, storedPassword);
    } catch (error) {
      throw new Error('Password validation failed');
    }
  };


module.exports = { createUserTable, hashPassword, validatePassword ,checkEmail};