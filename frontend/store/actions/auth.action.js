import { CONNECT, DISCONNECT } from "./actionTypes";

export const connectUserAction = ({ principal }) => {
  return {
    type: CONNECT,
    payload: {
      isConnected: true,
      principal,
    },
  };
};

export const disconnectUserAction = () => {
  return {
    type: DISCONNECT,
  };
};
