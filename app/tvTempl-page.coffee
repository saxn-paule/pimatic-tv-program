$(document).on( "templateinit", (event) ->
# define the item class
	class tvProgramDeviceItem extends pimatic.DeviceItem
		constructor: (templData, @device) ->
			@id = @device.id
			super(templData,@device)

		afterRender: (elements) ->
			super(elements)

			@getAttribute('schedule').value.subscribe( (newval) =>
				console.log("updated")
				console.log(newval)
				$("#"+@id+"_tv_program_placeholder").html(newval)
			)

			return
			
	# register the item-class
	pimatic.templateClasses['tvProgram'] = tvProgramDeviceItem
)