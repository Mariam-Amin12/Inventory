const pool = require('../config/db');

// Common function to handle errors
const handleQuery = async (query, values, res) => {
  try {
    const result = await pool.query(query, values);
    return result;
  } catch (error) {
    console.error(error);
    res.status(500).send('Server error');
  }
};

// Get all items
const getMecanicalItems = async (req, res) => {
  const result = await handleQuery('SELECT * FROM mechanical_items', [], res);
  res.json(result.rows);
};

const getRowItems = async (req, res) => {
    const result = await handleQuery('SELECT * FROM raw_material_items', [], res);
    res.json(result.rows);
};

const getElectricalItems = async (req, res) => {
    const result = await handleQuery('SELECT * FROM electrical_items', [], res);
    res.json(result.rows);
  };

// Add item based on type
const addItem = async (req, res) => {
  const {item_type, item_name, description, quantity, material_type, dymention, weight, voltage, current, power, type, purity } = req.body;

  let query;
  let values;

  switch (item_type) {
    case 'Mechanical':
      query = 'INSERT INTO mechanical_items (item_name, description, quantity, material_type, dymention, weight) VALUES ($1, $2, $3, $4, $5, $6)';
      values = [item_name, description, quantity, material_type, dymention, weight];
      break;
    case 'RawMaterial':
      query = 'INSERT INTO raw_material_items (item_name, description, quantity, type, purity) VALUES ($1, $2, $3, $4, $5)';
      values = [item_name, description, quantity, type, purity];
      break;
    case 'Electrical':
      query = 'INSERT INTO electrical_items (item_name, description, quantity, voltage, current, power) VALUES ($1, $2, $3, $4, $5, $6)';
      values = [item_name, description, quantity, voltage, current, power];
      break;
    default:
      return res.status(400).send('Invalid item type');
  }

  await handleQuery(query, values, res);
  res.status(201).send('Item added');
};

// Delete item based on type and id
const deleteItem = async (req, res) => {
  const { id, item_type } = req.body;

  // Convert id to an integer
  const intId = parseInt(id, 10);

  // Ensure id is a valid integer
  if (isNaN(intId)) {
    return res.status(400).send('Invalid id type');
  }

  // Log the item_type to debug
  console.log('Received item_type:', item_type);

  let query;
  switch (item_type) {
    case 'Mechanical':
      query = 'DELETE FROM mechanical_items WHERE id = $1';
      break;
    case 'RawMaterial':
      query = 'DELETE FROM raw_material_items WHERE id = $1';
      break;
    case 'Electrical':
      query = 'DELETE FROM electrical_items WHERE id = $1';
      break;
    default:
      return res.status(400).send('Invalid item type');
  }

  await handleQuery(query, [intId], res);
  res.status(200).send('Item deleted');
};



module.exports = { getMecanicalItems,getRowItems,getElectricalItems, addItem, deleteItem };