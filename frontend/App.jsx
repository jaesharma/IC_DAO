import React from "react";
/*
 * Connect2ic provides essential utilities for IC app development
 */
import { createClient } from "@connect2ic/core";
import { defaultProviders } from "@connect2ic/core/providers";
import { Connect2ICProvider, useConnect } from "@connect2ic/react";
import "@connect2ic/core/style.css";
/*
 * Import canister definitions like this:
 */
import * as DAO from "../.dfx/local/canisters/dao";
/*
 * Some examples to get you started
 */
import { useDispatch, useSelector } from "react-redux";

import { connectUserAction } from "./store/actions/auth.action";
import ConnectionPage from "./components/connectionPage";
import HomePage from "./components/HomePage";

const App = () => {
  const dispatch = useDispatch();

  const authState = useSelector((selector) => selector.authReducer);

  const _ = useConnect({
    onConnect: (props) => {
      // connected
      dispatch(connectUserAction({ principal: props.principal }));
    },
    onDisconnect: () => {
      // Signed out
      dispatch(connectUserAction());
    },
  });

  return (
    <div className="App">
      {authState.isConnected ? <HomePage /> : <ConnectionPage />}
    </div>
  );
};

const client = createClient({
  canisters: {
    DAO,
  },
  providers: defaultProviders,
  globalProviderConfig: {
    /*
     * Disables dev mode in production
     * Should be enabled when using local canisters
     */
    dev: import.meta.env.DEV,
  },
});

export default () => (
  <Connect2ICProvider client={client}>
    <App />
  </Connect2ICProvider>
);
