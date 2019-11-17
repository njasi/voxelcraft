const router = require("express").Router();
const { Block, Type } = require("../db/models");
module.exports = router;

router.get("/", async (req, res, next) => {
  try {
    const blocks = await Block.findAll();
    res.json(blocks).status(200);
  } catch (error) {
    next(error);
  }
});

router.post("/", async (req, res, next) => {
  try {
    const { xPos, yPos, zPos, type } = req.body;
    const block = await Block.create({ xPos, yPos, zPos, type });
    res.json(block).status(201);
  } catch (err) {
    next(err);
  }
});

// router.delete("/", async (req, res, next) => {});
