import React, { Component } from 'react';
import styles from "./App.module.scss";

var CanvasJSReact = require('./assets/canvasjs.react');
var CanvasJS = CanvasJSReact.CanvasJS;
var CanvasJSChart = CanvasJSReact.CanvasJSChart;

class List extends Component {
  // Initialize the state
  constructor(props){
    super(props);
    this.state = {
      data: []
    };
  }

  componentDidMount() {
    fetch("http://localhost:8080/api.json")
      .then(res => res.json())
      .then(res => this.setState({ data: res }))
      .catch(err => console.log(err));
  }

  render() {
    const options = {
      title: {
        text: "Basic Column Chart in React"
      },
      data: [{				
                type: "column",
                dataPoints: [
                    { label: "Apple",  y: 10  },
                    { label: "Orange", y: 15  },
                    { label: "Banana", y: 25  },
                    { label: "Mango",  y: 30  },
                    { label: "Grape",  y: 28  }
                ]
       }]
   }
    return (
      <div className={styles.Main}>
        <div></div>
        <div className={styles.Container}>
        <p></p>
          <h2>Members</h2>
          {this.state.data.map((item, i) => {
            return (
              <div key={i} className={styles.Data}>
                <ul class="list-group">
                  <li class="list-group-item">Username: {item.username}</li>
                  <li class="list-group-item">Email: {item.email}</li>
                  <li class="list-group-item">Name: {item.firstname} {item.lastname}</li>
                </ul>
              </div>
            );
          })}
        </div>
      </div>

    );
  }
}

export default List;