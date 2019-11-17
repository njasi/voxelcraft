import React from "react";

import { Info, Routes } from "./components";

import { ToastContainer } from "react-toastify";
import "!style-loader!css-loader!react-toastify/dist/ReactToastify.css";

const App = () => {
  return (
    <div>
      <ToastContainer />
      <Info />
      <Routes />
    </div>
  );
};

export default App;
