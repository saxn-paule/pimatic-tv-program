$(document).on( "templateinit", (event) ->
# define the item class
	class tvProgramDeviceItem extends pimatic.DeviceItem
		constructor: (templData, @device) ->
			@id = @device.id
			super(templData,@device)

		afterRender: (elements) ->
			super(elements)

			renderSchedule = (newval) =>
				$("#"+@id+"_tv_program_placeholder").html(newval)

			renderSchedule(@getAttribute('schedule').value())

			@getAttribute('schedule').value.subscribe(renderSchedule)

			return
			
	# register the item-class
	pimatic.templateClasses['tvProgram'] = tvProgramDeviceItem
)