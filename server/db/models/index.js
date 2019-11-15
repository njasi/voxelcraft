const db = require("../db");

const Block = require("./block");
const Type = require("./type");

Block.hasOne(Type);
Type.belongsTo(Block);

module.exports = {
  Block,
  Type
};
