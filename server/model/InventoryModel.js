const pool = require('../config/db');

const createInventoryTable = async () => {
  const query = `
    CREATE TABLE IF NOT EXISTS inventory_items (
      id SERIAL PRIMARY KEY,
      item_name VARCHAR(100) NOT NULL,
      item_type VARCHAR(50) NOT NULL,
      description TEXT,
      quantity INT NOT NULL,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
  `;
  await pool.query(query);
};

module.exports = { createInventoryTable };