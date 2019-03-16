import CanvasJSReact from './assets/canvasjs.react';

/* App.js */
var React = require('react');
var Component = React.Component;
var CanvasJS = CanvasJSReact.CanvasJS;
var CanvasJSChart = CanvasJSReact.CanvasJSChart;
class Age extends Component {
		// Initialize the state
		constructor(props){
			super(props);
			this.state = {
				datas: [],
	
			};
		}
		componentDidMount() {
			fetch("http://localhost:8080/api/age")
				.then(res => res.json())
				.then(res => this.setState({ datas: res }))
				.catch(err => console.log(err));
		}
	render() {
		for (let i = 0; i < this.state.datas.length; i++) {
			this.state.datas[i]['y'] = Number(this.state.datas[i]['y']);
		}
		console.log(this.state.datas);
		const options = {
			title: {
				text: "Most Popular Age by Zipcode"
			},
			axisX: {
				title: "Zipcode",
				reversed: true,
				interval: 1
			},
			axisY: {
				title: "Most Common Age",
			},
			data: [
			{
				// Change type to "doughnut", "line", "splineArea", etc.
				type: "column",
				dataPoints: this.state.datas
			}
			]
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
export default Age;