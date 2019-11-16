import React from "react";
import PropTypes from "prop-types";
import { connect } from "react-redux";
import { Link } from "react-router-dom";

class Navbar extends React.Component {
  render() {
    return (
      <div>
        <nav className="navbar navbar-expand-lg navbar-dark bg-primary">
          <h1 className="navbar-brand">VoxelCraft</h1>
          <div className="navbar-nav">
            <div className="nav-item">
              <Link className="nav-link" to="/home">
                HOME
              </Link>
            </div>
            <div className="nav-item">
              <Link className="nav-link" to="/about">
                ABOUT
              </Link>
            </div>
          </div>
        </nav>
        <hr />
      </div>
    );
  }
}

export default Navbar;
