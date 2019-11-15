import React from 'react'

import {Navbar} from './components'
import Routes from './routes'

import {ToastContainer} from 'react-toastify'
import "!style-loader!css-loader!react-toastify/dist/ReactToastify.css"

const App = () => {
  return (
    <div>
      <ToastContainer />
      <Navbar />
      <Routes />
    </div>
  )
}

export default App
