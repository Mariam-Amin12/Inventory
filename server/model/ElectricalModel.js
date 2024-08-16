const pool = require('../config/db');

const createElectricalTable = async () => {
  const query = `
    CREATE TABLE IF NOT EXISTS electrical_items (
      id SERIAL PRIMARY KEY,
      item_name VARCHAR(100) NOT NULL,
      description TEXT,
      quantity INT NOT NULL,
      voltage DECIMAL,
      current DECIMAL,
      power DECIMAL,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
  `;
  await pool.query(query);
};

module.exports = { createElectricalTable };