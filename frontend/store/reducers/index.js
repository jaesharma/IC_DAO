import { combineReducers } from "redux";

import prefReducer from "./pref.reducer";
import authReducer from "./auth.reducer";

const rootReducer = combineReducers({
  authReducer,
  prefReducer,
});

export default rootReducer;
