# #vvo configuration options
# Declare your config option for your plugin here. 
module.exports = {
	title: "tv program config options"
	type: "object"
	properties:
		time:
			description: "Which program do you want to get? could be \"now\", \"20:15\" or \"22:00\""
			type: "string"
			default: "now"
}