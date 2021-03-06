// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css";

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html";

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
//
//

import React, { Fragment } from "react";
import ReactDOM from "react-dom";
import { Provider } from "react-redux";
import { BrowserRouter as Router } from "react-router-dom";
import FgForm from "./form-generator";
import createReduxStore from "./create-redux-store";

const store = createReduxStore();

class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      formFields: [{ name: "name", type: "email" }]
    };
  }

  addRow = obj => e => {
    this.setState(previousState => ({
      formFields: [...previousState.formFields, obj]
    }));
  };

  render() {
    return (
      <Fragment>
        <FgForm fields={this.state.formFields} addRowHandler={this.addRow} />
      </Fragment>
    );
  }
}

ReactDOM.render(
  <Provider store={store}>
    <Router>
      <App />
    </Router>
  </Provider>,
  document.getElementById("spawn-app")
);

export default App;
