const db = require("../db");

const Block = require("./block");
const Type = require("./type");

Block.hasOne(Type);

module.exports = {
  Block,
  Type
};
