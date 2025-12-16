sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/sapdev/eu/incidents/test/integration/pages/IncidentsList",
	"com/sapdev/eu/incidents/test/integration/pages/IncidentsObjectPage"
], function (JourneyRunner, IncidentsList, IncidentsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/sapdev/eu/incidents') + '/test/flp.html#app-preview',
        pages: {
			onTheIncidentsList: IncidentsList,
			onTheIncidentsObjectPage: IncidentsObjectPage
        },
        async: true
    });

    return runner;
});

