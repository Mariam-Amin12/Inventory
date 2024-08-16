

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

	 CREATE TABLE IF NOT EXISTS raw_material_items (
      id SERIAL PRIMARY KEY,
      item_name VARCHAR(100) NOT NULL,
      description TEXT,
      quantity INT NOT NULL,
      type VARCHAR(50),
      purity DECIMAL,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
	 CREATE TABLE IF NOT EXISTS users (
      id SERIAL PRIMARY KEY,
      username VARCHAR(50) UNIQUE NOT NULL,
      password VARCHAR(255) NOT NULL,
      role VARCHAR(50) DEFAULT 'user'
    );


INSERT INTO electrical_items (item_name, description, quantity, voltage, current, power)
VALUES
  ('Resistor', 'A resistor is a passive two-terminal electrical component that implements electrical resistance as a circuit element.', 100, 5.0, 0.02, 0.1),
  ('Capacitor', 'A capacitor is a device that stores electrical energy in an electric field.', 50, 10.0, 0.01, 0.2),
  ('Inductor', 'An inductor, also called a coil, choke, or reactor, is a passive two-terminal electrical component that stores energy in a magnetic field.', 75, 15.0, 0.03, 0.45),
  ('Transformer', 'A transformer is a passive electrical device that transfers electrical energy from one electrical circuit to another, or multiple circuits.', 20, 220.0, 1.0, 220.0),
  ('Diode', 'A diode is a semiconductor device that allows current to flow in one direction only.', 200, 0.7, 0.005, 0.0035);


  INSERT INTO mechanical_items (item_name, description, quantity, material_type, dymention, weight)
VALUES
  ('Bolt', 'A bolt is a form of threaded fastener with an external male thread.', 150, 'Steel', 'M10x50', '50g'),
  ('Nut', 'A nut is a type of fastener with a threaded hole.', 300, 'Brass', 'M10', '10g'),
  ('Washer', 'A washer is a thin plate with a hole that is normally used to distribute the load of a threaded fastener.', 500, 'Stainless Steel', 'M10', '5g'),
  ('Gear', 'A gear is a rotating machine part having cut teeth or cogs.', 75, 'Aluminum', '50mm diameter', '200g'),
  ('Bearing', 'A bearing is a machine element that constrains relative motion to only the desired motion.', 100, 'Ceramic', '6205', '150g');

  INSERT INTO raw_material_items (item_name, description, quantity, type, purity)
VALUES
  ('Copper', 'Copper is a chemical element with the symbol Cu and atomic number 29.', 100, 'Metal', 99.9),
  ('Silicon', 'Silicon is a chemical element with the symbol Si and atomic number 14.', 200, 'Metalloid', 99.5),
  ('Iron', 'Iron is a chemical element with the symbol Fe and atomic number 26.', 150, 'Metal', 98.0),
  ('Aluminum', 'Aluminum is a chemical element with the symbol Al and atomic number 13.', 120, 'Metal', 99.7),
  ('Gold', 'Gold is a chemical element with the symbol Au and atomic number 79.', 50, 'Metal', 99.99);