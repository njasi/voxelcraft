const Sequelize = require("sequelize");
const db = require("../db");

const Type = db.define("type", {
  name: {
    type: Sequelize.STRING
  },
  minecraftId: {
    type: Sequelize.STRING
  },
  texture: {
    type: Sequelize.STRING,
    defaultValue: "unknown"
  }
});

module.exports = Type;
