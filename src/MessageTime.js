import CanvasJSReact from './assets/canvasjs.react';

/* App.js */
var React = require('react');
var Component = React.Component;
var CanvasJSChart = CanvasJSReact.CanvasJSChart;
var CanvasJS = CanvasJSReact.CanvasJS;
 
class MessageTime extends Component {	
	// Initialize the state
	constructor(props){
		super(props);
		this.state = {
			datas: [],

		};
	}

	componentDidMount() {

    fetch("http://localhost:8080/api/messages")
      .then(res => res.json())
      .then(res => this.setState({ datas: res }))
			.catch(err => console.log(err));
	
	}

	render() {

		for (let i = 0; i < this.state.datas.length; i++) {
			this.state.datas[i]['y'] = Number(this.state.datas[i]['y']);
			this.state.datas[i]['label'] = Number(this.state.datas[i]['label']);

		}

		console.log(this.state.datas);

		const options = {
				animationEnabled: true,	
				title:{
					text: "Most Active Time for Messages"
				},
				axisY : {
					title: "Number of Messages",
					includeZero: false
				},
				axisX : {
					title: "Time of Day",
					includeZero: false,
					interval: 1,
					intervalType: "hour"
				},
				toolTip: {
					shared: true
				},
				data: [{
					type: "spline",
					name: "#messages",
					showInLegend: true,
					dataPoints: this.state.datas
				}]
		}
		
		return (
		<div>
			<CanvasJSChart options = {options} 
				/* onRef={ref => this.chart = ref} */
			/>
			{/*You can get reference to the chart instance as shown above using onRef. This allows you to access all chart properties and methods*/}
		</div>
		);
	}
}
 
export default MessageTime;