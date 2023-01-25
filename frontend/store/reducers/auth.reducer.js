import { CONNECT, DISCONNECT } from "../actions/actionTypes";

const initialState = {
  isConnected: false,
  principal: null,
};

const authReducer = (state = initialState, action) => {
  switch (action.type) {
    case CONNECT: {
      return {
        ...state,
        isConnected: true,
        principal: action.payload.principal,
      };
    }
    case DISCONNECT: {
      return {
        ...state,
        isConnected: false,
        principal: null,
      };
    }
    default:
      return state;
  }
};

export default authReducer;
