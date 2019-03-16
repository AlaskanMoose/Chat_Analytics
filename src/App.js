import React, { Component } from 'react';
import { Route, Switch, Link } from 'react-router-dom';


import Home from './Home';
import List from './List';
import BarChart from './BarChart';
import MessageTime from './MessageTime';
import Device from './Device';
import Age from './Age';

import "./App.module.scss";

class App extends Component {
  render() {
    const App = () => (
      <div>
        <Switch>
          <Route exact path='/' component={Home}/>
          <Route path='/list' component={List}/>
          <Route path='/bar' component={BarChart}/>
          <Route path='/time' component={MessageTime}/>
          <Route path='/device' component={Device}/>
          <Route path='/age' component={Age}/>
        </Switch>
      </div>
    )
    return (
      <div>

        <div class="container justify-content-center">
            <h1 class="col text-center">Chatter Analytics</h1>
            {/* Link to List.js */}
            <div class="col text-center">
              <Link to={'./list'}>
                <button type="button" class="btn btn-outline-primary">
                    My Members
                </button>
              </Link>

              <Link to={'./bar'}>
                <button type="button" class="btn btn-outline-primary">
                  Zipcode
                </button>
              </Link>

              <Link to={'./time'}>
                <button type="button" class="btn btn-outline-primary">
                  Active Times
                </button>
              </Link>

              <Link to={'./device'}>
                <button type="button" class="btn btn-outline-primary">
                  Popular Devices
                </button>
              </Link>

              <Link to={'./age'}>
                <button type="button" class="btn btn-outline-primary">
                  Popular Age
                </button>
              </Link>
            </div>
      </div>

      <Switch>
        <App/>
      </Switch>
      </div>

    );
  }
}

export default App;
