const Sequelize = require("sequelize");
const db = require("../db");

const Block = db.define("block", {
  xPos: {
    type: Sequelize.INTEGER
  },
  yPos: {
    type: Sequelize.INTEGER
  },
  zPos: {
    type: Sequelize.INTEGER
  },
  type: {
    type: Sequelize.STRING
  }
});

module.exports = Block;
