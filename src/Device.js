import CanvasJSReact from './assets/canvasjs.react';

/* App.js */
var React = require('react');
var Component = React.Component;
var CanvasJS = CanvasJSReact.CanvasJS;
var CanvasJSChart = CanvasJSReact.CanvasJSChart;
class Device extends Component {
	// Initialize the state
	constructor(props){
		super(props);
		this.state = {
			datas: [],

		};
	}

	componentDidMount() {
    fetch("http://localhost:8080/api/device")
      .then(res => res.json())
      .then(res => this.setState({ datas: res }))
			.catch(err => console.log(err));

			
	}
	render() {
		for (let i = 0; i < this.state.datas.length; i++) {
			this.state.datas[i]['y'] = Number(this.state.datas[i]['y']);
		}
		console.log(this.state.datas);

		var dataPoint;
		var total;
		const options = {
			animationEnabled: true,
			exportEnabled: true,
			theme: "dark2", // "light1", "dark1", "dark2"
			title:{
				text: "Most Popular Devices "
			},
			data: [{
				type: "pie",
				indexLabel: "{label}: {percentage}%",		
				startAngle: -90,
				dataPoints: this.state.datas
			}]
		}
		//calculate percentage
		if (this.state.datas.length > 0) {
			dataPoint = options.data[0].dataPoints;
			total = 0;
			for (let i = 0; i < dataPoint.length; i++) {
				total += dataPoint[i].y;
			}
	
			for(var i = 0; i < dataPoint.length; i++) {

					options.data[0].dataPoints[i].percentage = ((dataPoint[i].y / total) * 100).toFixed(2);
				
			}
		}

		return (
		<div>
			<CanvasJSChart options = {options}
				 /*onRef={ref => this.chart = ref}*/
			/>
			{/*You can get reference to the chart instance as shown above using onRef. This allows you to access all chart properties and methods*/}
		</div>
		);
	}
}
export default Device;