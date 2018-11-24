import { createStore } from "redux";
import rootReducer from "./reducers";

const createReduxStore = () => {
  return createStore(
    rootReducer,
    window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__()
  );
};

export default createReduxStore;
