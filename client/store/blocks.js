import axios from "axios";
import { toast } from "react-toastify";

const GOT_BLOCKS = "GOT_BLOCKS";
const BLOCK_WAS_SET = "BLOCK_WAS_SET";
const BLOCK_WAS_REMOVED = "BLOCK_WAS_REMOVED";

export const gotBlocks = blocks => ({
  type: GOT_BLOCKS,
  blocks
});

export const blockWasSet = block => ({
  type: BLOCK_WAS_SET,
  block
});

export const blockWasRemoved = block => ({
  type: BLOCK_WAS_REMOVED,
  block
});

export const fetchBlocks = () => {
  return async dispatch => {
    try {
      const { data } = await axios.get("/api/blocks");
      console.log("BLOCK DATA:\t", data);
      dispatch(gotBlocks(data));
    } catch (err) {
      console.log(err)
      toast.error("There was an error loading the blocks...\n", err);
    }
  };
};

export const setBlock = block => {
  return async dispatch => {
    try {
      const { data } = await axios.post("/api/blocks", block);
      console.log(data);
      dispatch(blockWasSet(data[0]));
    } catch (err) {
      toast.error("There was an error placing the block..\n", err);
    }
  };
};

export const removeBlock = block => {
  return async dispatch => {
    try {
      const { data } = await axios.delete("/api/blocks", { data: block });
      dispatch(blockWasRemoved(data));
    } catch (err) {
      console.log(err);
      toast.error("There was an error removing the block...\n", err);
    }
  };
};

const initialState = [];
const makeKey = block => `${block.xPos},${block.yPos},${block.yPos}`;
const reducer = (state = initialState, action) => {
  switch (action.type) {
    case GOT_BLOCKS: {
      const dict = {};
      for (let block of action.blocks) {
        dict[makeKey(block)] = block;
      }
      return action.blocks;
    }
    case BLOCK_WAS_SET: {
      const key = makeKey(action.block);
      return { ...state, [key]: action.block };
    }
    case BLOCK_WAS_REMOVED: {
      const copy = { ...state };
      delete copy[makeKey(action.block)];
      return copy;
    }
    default: {
      return state;
    }
  }
};

export default reducer;
