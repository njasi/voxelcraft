import React, { Component } from "react";
import { connect } from "react-redux";
import { withRouter, Route, Switch, Redirect } from "react-router-dom";
import { Voxel } from "./index";

class Routes extends Component {
  render() {
    return (
      <Switch>
        <Route exact path="/home" component={Voxel} />
      </Switch>
    );
  }
}

const mapState = state => {
  return {};
};

const mapDispatch = dispatch => {
  return {};
};

export default withRouter(connect(mapState, mapDispatch)(Routes));
