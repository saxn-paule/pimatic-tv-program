# iframe configuration options
module.exports = {
	title: "tvProgram"
	TvProgramDevice :{
		title: "Plugin Properties"
		type: "object"
		extensions: ["xLink"]
		properties:
			time:
				description: "Which program do you want to get? could be \"now\", \"20:15\" or \"22:00\""
				type: "string"
				default: "now"
	}
}
