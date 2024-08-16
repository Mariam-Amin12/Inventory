const pool = require('../config/db');

const createMechanicalTable = async () => {
  const query = `
    CREATE TABLE IF NOT EXISTS mechanical_items (
      id SERIAL PRIMARY KEY,
      item_name VARCHAR(100) NOT NULL,
      description TEXT,
      quantity INT NOT NULL,
      material_type VARCHAR(50),
      dymention VARCHAR(50),
      weight VARCHAR(50),
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
  `;
  await pool.query(query);
};

module.exports = { createMechanicalTable };