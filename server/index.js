const express = require('express');
const app = express();
const port = 8080;
// const userRoutes = require('./routes/AuthRoutes');
const inventoryRoutes = require('./routes/InventoryRoutes');
const authRoutes = require('./routes/AuthRoutes');
const authMiddleware = require('./middlewares/AuthMiddlewares');
require('dotenv').config();

app.use(express.json());
app.get('/test', (req, res) => {
  res.send({ message: 'API is working!' });
});


app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.use('/auth', authRoutes);
// app.use('/api/users', authMiddleware, userRoutes);
app.use('/inventory',authMiddleware, inventoryRoutes);

app.listen(port, async () => {
  console.log(`Server running on port ${port}`);
});