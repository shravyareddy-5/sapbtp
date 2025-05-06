@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection view for booking details'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo.typeNamePlural: 'Bookings'
@Search.searchable: true
define view entity ZM_PROJ_apprBOOKING as projection on zm_i_booking
{
@UI.facet: [{ id:'Booking',
purpose:#STANDARD,
 type:#IDENTIFICATION_REFERENCE,
 label:'Booking',
 position:10},
 {
 id:'BookingS',
purpose:#STANDARD,
 type:#LINEITEM_REFERENCE,
 label:'BookingSuppl',
 position:60,
 targetElement:'_BOOKINGSUPPL'
 }]
 @UI.lineItem: [{position:10}]
 @UI.identification: [{position:10}]
 @Search.defaultSearchElement: true
    key travel_id,
    @UI.lineItem: [{position:20}]   
 @UI.identification: [{position:20}]
    key booking_id,
    @UI.lineItem: [{position:30}]   
 @UI.identification: [{position:30}]
    booking_date,
    @UI.lineItem: [{position:40}]  
 @UI.identification: [{position:40}]
 @Consumption.valueHelpDefinition: [{entity:{name:'/dmo/i_customer', element:'CustomerID'}   }]
 @ObjectModel.text.element: [ 'CustomerName' ]
    customer_id as CustomerID,
    _customer.LastName as CustomerName,
    @UI.lineItem: [{position:50}]   
 @UI.identification: [{position:50}]
  @Consumption.valueHelpDefinition: [{entity:{name:'/dmo/i_carrier', element:'AirlineID'} }]
 @ObjectModel.text.element: [ 'CarrierName' ]
    carrier_id as CarrierID,
    _carrier.Name as CarrierName,
    @UI.lineItem: [{position:60}]    
 @UI.identification: [{position:60}]
  @Consumption.valueHelpDefinition: [{entity:{name:'/dmo/i_connection', element:'ConnectionID'},
  additionalBinding:[{localElement:'CarrierID', element:'AirlineID' } ]   }]
    connection_id as ConnectionID,
    @UI.lineItem: [{position:70}]   
 @UI.identification: [{position:70}]
    flight_date,
    @Semantics.amount.currencyCode: 'currency_code'
    @UI.lineItem: [{position:80}]    
 @UI.identification: [{position:80}]
    flight_price,
    @UI.lineItem: [{position:90}]   
 @UI.identification: [{position:90}]
    currency_code,
    lastchangedat,
    /* Associations */
    _carrier,
    _connection,
    _customer,
    _travel : redirected to parent zm_proj_apprtravel
}
