sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/sapdev/eu/incidents2/test/integration/pages/IncidentsList",
	"com/sapdev/eu/incidents2/test/integration/pages/IncidentsObjectPage",
	"com/sapdev/eu/incidents2/test/integration/pages/Incidents_conversationObjectPage"
], function (JourneyRunner, IncidentsList, IncidentsObjectPage, Incidents_conversationObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/sapdev/eu/incidents2') + '/test/flp.html#app-preview',
        pages: {
			onTheIncidentsList: IncidentsList,
			onTheIncidentsObjectPage: IncidentsObjectPage,
			onTheIncidents_conversationObjectPage: Incidents_conversationObjectPage
        },
        async: true
    });

    return runner;
});

