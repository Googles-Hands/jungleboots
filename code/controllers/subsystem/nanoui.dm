SUBSYSTEM_DEF(nano)
	name  = "Nano UI"
	wait  = 2 SECONDS
	priority = SS_PRIORITY_NANOUI
	runlevels = RUNLEVELS_DEFAULT|RUNLEVEL_LOBBY
	var/list/currentrun = list()
	var/datum/nanomanager/nanomanager

/datum/controller/subsystem/nano/New()
	. = ..()

	nanomanager = new()

/datum/controller/subsystem/nano/stat_entry(msg)
	msg = "P:[nanomanager.processing_uis.len]"
	return ..()

/datum/controller/subsystem/nano/fire(resumed = FALSE)
	if (!resumed)
		currentrun = nanomanager.processing_uis.Copy()

	while (currentrun.len)
		var/datum/nanoui/UI = currentrun[currentrun.len]
		currentrun.len--

		if (!UI || QDELETED(UI))
			continue

		UI.process()

		if (MC_TICK_CHECK)
			return
