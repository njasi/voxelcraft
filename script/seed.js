"use strict";

const db = require("../server/db");
const { Block, Type } = require("../server/db/models");

function makeBlock(xPos, yPos, zPos, type) {
  return Block.create({
    xPos,
    yPos,
    zPos,
    type
  });
}

async function seed() {
  await db.sync({ force: true });
  console.log("db synced!");
  await Promise.all([
    makeBlock(0, 0, 0, "stone"),
    makeBlock(0, 0, 19, "stone")
  ])
  console.log(`seeded successfully`);
}

async function runSeed() {
  console.log("seeding...");
  try {
    await seed();
  } catch (err) {
    console.error(err);
    process.exitCode = 1;
  } finally {
    console.log("closing db connection");
    await db.close();
    console.log("db connection closed");
  }
}
if (module === require.main) {
  runSeed();
}
