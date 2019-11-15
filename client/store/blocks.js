import axios from "axios";
import { toast } from "react-toastify";

const GOT_BLOCKS = "GOT_BLOCKS";
const BLOCK_WAS_SET = "BLOCK_WAS_SET";

export const gotBlocks = blocks => {
  type: GOT_BLOCKS, blocks;
};

export const blockWasSet = block => {
  type: BLOCK_WAS_SET, block;
};

export const fetchBlocks = () => {
  return async dispatch => {
    try {
      const { data } = axios.get("/api/blocks");
      dispatch(blockWasSet(data));
    } catch (err) {
      toast.error("There was an error placing the block.");
    }
  };
};

export const setBlock = block => {
  return async dispatch => {
    try {
      const { data } = axios.put("/api/blocks", block);
      dispatch(gotBlocks(data));
    } catch (err) {
      toast.error("There was an error getting the cube.");
    }
  };
};

const initialState = {};

const reducer = (state = initialState, action) => {
  switch (action.type) {
    case GOT_BLOCKS: {
      return action.blocks;
    }
    case BLOCK_WAS_SET: {
      const key = `${action.block.x},${action.block.y}`;
      return {...state, [key] : action.block}
    }
    default:{
      return state
    }
  }
};

export default reducer;
