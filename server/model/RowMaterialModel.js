const pool = require('../config/db');

const createRawMaterialTable = async () => {
  const query = `
    CREATE TABLE IF NOT EXISTS raw_material_items (
      id SERIAL PRIMARY KEY,
      item_name VARCHAR(100) NOT NULL,
      description TEXT,
      quantity INT NOT NULL,
      type VARCHAR(50),
      purity DECIMAL,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
  `;
  await pool.query(query);
};

module.exports = { createRawMaterialTable };