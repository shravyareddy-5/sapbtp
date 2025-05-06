@AbapCatalog.sqlViewName: 'ZUNMFINAL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'unmanaged RAP for travel details'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo.typeNamePlural: 'Travels'
@Search.searchable: true
define root view zum_c_travel as select from /dmo/travel as Travel association[1] to zunm_agency as _agency
on $projection.AgencyId = _agency.AgencyId
association[1] to zunm_customer as _customer
on $projection.CustomerId = _customer.CustomerId
association[1] to I_Currency as _currency
on $projection.CurrencyCode = _currency.Currency
{
@UI.facet: [{purpose:#STANDARD,type:#IDENTIFICATION_REFERENCE,label:'Details',position:10 }]
@UI.lineItem: [{position:10,label:'Travel No'}]
//@UI.identification: [{position:10,label:'Travel No'}]
 key travel_id as TravelId,
 @UI.selectionField: [{position:10}]
 @UI.lineItem: [{position:20,label:'Agency No'}]
 @UI.identification: [{position:20,label:'Agency No'}]
 @ObjectModel.text.association: '_Agency'
 @Consumption.valueHelpDefinition: [{entity:{name:'zunm_agency', element:'AgencyId'} }]
 @Search.defaultSearchElement: true
 @Search.fuzzinessThreshold: 0.7
 agency_id as AgencyId,
  @UI.selectionField: [{position:20 }]
  @UI.lineItem: [{position:30,label:'Customer No'}]
  @UI.identification: [{position:30,label:'Customer No'}]
  @ObjectModel.text.association: '_Customer'
  @Consumption.valueHelpDefinition: [{entity:{name:'zunm_customer', element:'CustomerId'} }]
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.7
 customer_id as CustomerId,
 @UI.identification: [{position:40}]
 begin_date as BeginDate,
 @UI.identification: [{position:50}]
 end_date as EndDate,
 @UI.identification: [{position:60}]
 booking_fee as BookingFee,
 @UI.lineItem: [{position:40}]
 @UI.identification: [{position:70}]
 total_price as TotalPrice,
 @UI.lineItem: [{position:50}]
 @UI.identification: [{position:80}]
 currency_code as CurrencyCode,
 @UI.lineItem: [{position:60}]
 @UI.identification: [{position:90}]
 description as Description,
 @UI.lineItem: [{position:70}]
 @UI.identification: [{position:100,label:'Status'}]
 status as Status,
 _agency,
 _customer,
 _currency
 
}
