sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/sapdev/eu/customers/test/integration/pages/CustomersList",
	"com/sapdev/eu/customers/test/integration/pages/CustomersObjectPage",
	"com/sapdev/eu/customers/test/integration/pages/AddressesObjectPage"
], function (JourneyRunner, CustomersList, CustomersObjectPage, AddressesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/sapdev/eu/customers') + '/test/flp.html#app-preview',
        pages: {
			onTheCustomersList: CustomersList,
			onTheCustomersObjectPage: CustomersObjectPage,
			onTheAddressesObjectPage: AddressesObjectPage
        },
        async: true
    });

    return runner;
});

