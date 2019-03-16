import React, { Component } from 'react';
import { render } from 'react-dom';
import { BrowserRouter } from 'react-router-dom';
import App from "./App";
import 'bootstrap/dist/css/bootstrap.css';
import './App.module.scss';

render((
	
	<BrowserRouter>
			<App/>
	</BrowserRouter>
), document.getElementById('root'));
