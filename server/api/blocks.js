const router = require("express").Router();
const Sequelize = require("sequelize");
const { Block, Type } = require("../db/models");
module.exports = router;

router.get("/", async (req, res, next) => {
  try {
    const blocks = await Block.findAll({
      attributes: ["xPos", "yPos", "zPos", "type"]
    });
    res.json(blocks).status(200);
  } catch (error) {
    next(error);
  }
});

// so I know if I need to update the blocks in the minecraft world
router.get("/newest", async (req, res, next) => {
  Block.max("id")
    .then(max => {
      res.json(max).status(200);
    })
    .catch(err => next(err));
});

router.post("/", async (req, res, next) => {
  try {
    const { xPos, yPos, zPos, type } = req.body;
    const block = await Block.findOrCreate({
      where: { xPos, yPos, zPos }
    });
    block[0].type = type;
    await block[0].save();
    res.json(block).status(201);
  } catch (err) {
    next(err);
  }
});

router.delete("/", async (req, res, next) => {
  try {
    const { xPos, yPos, zPos } = req.body;
    const block = await Block.destroy({ where: { xPos, yPos, zPos } });
    res.json(block).status(201);
  } catch (err) {
    next(err);
  }
});
