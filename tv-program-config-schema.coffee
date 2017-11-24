# #tv program configuration options
module.exports = {
	title: "tv program config options"
	type: "object"
	properties:
		time:
			description: "Which program do you want to get? could be \"now\", \"20:15\" or \"22:00\""
			type: "string"
			default: "now"
		interval:
			description: "How often should the data be refreshed? In minutes."
			type: "number"
			default: 5
		short:
			description: "Show only short information without pictures and description"
			type: "boolean"
			default: false
		stations:
			description: "Which stations should be shown. Separate by ;"
			type: "string"
			default: "all"
}