import React, { Component } from 'react';
import CanvasJSReact from './assets/canvasjs.react';
var CanvasJSChart = CanvasJSReact.CanvasJSChart;
var CanvasJS = CanvasJSReact.CanvasJS;
 
class BarChart extends Component {
  // Initialize the state
  constructor(props){
    super(props);
    this.state = {
			datas: [],
			members: [],
			selectedMember: "",
			validationError: ""

    };
	}
	
	addSymbols(e){
		var suffixes = ["", "K", "M", "B"];
		var order = Math.max(Math.floor(Math.log(e.value) / Math.log(1000)), 0);
		if(order > suffixes.length - 1)
			order = suffixes.length - 1;
		var suffix = suffixes[order];
		return CanvasJS.formatNumber(e.value / Math.pow(1000, order)) + suffix;
	}
	componentDidMount() {
		fetch("http://localhost:8080/api/members")
			.then(res => res.json())
			.then(res => {
				let membersFromApi = res.map(member => {return {value: member, display: member}})
				this.setState({members:[{value: '', display: '(Select your favorite team)'}].concat(membersFromApi)});
			})
			.catch(err => console.log(err));

    fetch("http://localhost:8080/api/zipcode")
      .then(res => res.json())
      .then(res => this.setState({ datas: res }))
			.catch(err => console.log(err));

			
	}
	// onMemberSelected(e) {
	// 	console.log("PARAMETRIC" + e.target.value);

	// 	this.setState({selectedMember: e.target.value, 
	// 		validationError: e.target.value === "" ? "You must select your favourite team" : ""})

	// 	console.log(this.state.selectedMember);

	// 		fetch("http://localhost:8080/api/zipcode", {body : this.state.selectedMember.memberid})
	// 			.then(res => res.json())
	// 			.then(res => this.setState({ datas: res}))
	// 			.catch(err => console.log(err));

	// }
	render() {
		for (let i = 0; i < this.state.datas.length; i++) {
			this.state.datas[i]['y'] = Number(this.state.datas[i]['y']);
		}

		const options = {
			height:500,
			animationEnabled: true,
			theme: "light2",
			title:{
				text: "Most Popular Zipcode among Users" + this.state.selectedMember
			},
			axisX: {
				title: "Zipcode",
				reversed: true,
				interval: 1
			},
			axisY: {
				title: "Number of users with that Zipcode",
				labelFormatter: this.addSymbols,
			},
			data: [{
				type: "bar",

				dataPoints: this.state.datas
			}]
		}
		
		return (
		<div>
			<h1>React Bar Chart</h1>
			<select value={this.state.selectedMember} 
                onChange={(e) => this.setState({selectMember: e.target.value, validationError: e.target.value === "" ? "You must select your favourite team" : ""})}>
          {this.state.members.map((member) => <option key={member.value.memberid} value={member.value}>{member.display.username}</option>)}
			</select>
			<div style={{color: 'red', marginTop: '5px'}}>
				{this.state.validationError}
			</div>
			
			<CanvasJSChart options = {options} 
				/* onRef={ref => this.chart = ref} */
			/>
			{/*You can get reference to the chart instance as shown above using onRef. This allows you to access all chart properties and methods*/}
		</div>
		);
	}
}

export default BarChart;