const router = require("express").Router();
const { Block, Type } = require("../db/models");
module.exports = router;

router.get("/", async (req, res, next) => {
  try {
    const allcategory = await Block.findAll({
      include: { model: Type, attributes: [req.attrs.split(",")] }
    });
    res.json(allcategory).status(200);
  } catch (error) {
    next(error);
  }
});

router.post("/", async (req, res, next) => {
  try {
    const { xPos, yPos, zPos, typeId } = req.body;
    const block = await Block.create({ xPos, yPos, zPos });
    const type = await Type.findOne({ where: { id: typeId } });
    await block.setType(type);
    res.json(block).status(201);
  } catch (err) {
    next(err);
  }
});

// router.delete("/", async (req, res, next) => {});
