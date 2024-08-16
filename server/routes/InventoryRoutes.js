const express = require('express');
const {
  getMecanicalItems,
  getRowItems,
  getElectricalItems,
  addItem,
  deleteItem
} = require('../controller/InventoryController');
const router = express.Router();

router.get('/items/mechanical', getMecanicalItems);
router.get('/items/raw', getRowItems);
router.get('/items/electrical', getElectricalItems);

router.post('/items', addItem);

router.delete('/items/delete', deleteItem);

module.exports = router;