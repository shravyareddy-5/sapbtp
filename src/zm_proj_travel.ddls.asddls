@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection view'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo.typeNamePlural: 'Travels'
@Search.searchable: true
define root view entity zm_proj_travel
  as projection on zm_i_travel
{
      @UI.facet: [{ id:'Travel',
      purpose:#STANDARD,
       type:#IDENTIFICATION_REFERENCE,
       label:'Travel',
       position:10},
       {
       id:'Booking',
      purpose:#STANDARD,
       type:#LINEITEM_REFERENCE,
       label:'Booking',
       position:60,
       targetElement:'_booking'
       }]
      @UI.lineItem: [{position:10, type:#FOR_ACTION, dataAction:'createTravelbyTemplate',label:'copy'}]
      @UI.identification: [{position:10}]
      @Search.defaultSearchElement: true
  key travel_id,
      @UI.lineItem: [{position:20}]
      @UI.selectionField: [{position:10}]
      @UI.identification: [{position:20}]
      @Consumption.valueHelpDefinition: [{entity:{name:'/dmo/i_agency', element:'AgencyID' } }]
      @ObjectModel.text.element: [ 'AgencyName' ]
      agency_id           as AgencyID,
      _agency.name        as AgencyName,
      @UI.lineItem: [{position:30}]
      @UI.selectionField: [{position:20}]
      @UI.identification: [{position:30}]
      @Consumption.valueHelpDefinition: [{entity:{name:'/dmo/i_customer', element:'CustomerID' } }]
      @ObjectModel.text.element: [ 'CustomerName' ]
      customer_id         as CustomerID,
      _customer.last_name as CustomerName,
      @UI.identification: [{position:40}]
      begin_date,
      @UI.identification: [{position:50}]
      end_date,
      @Semantics.amount.currencyCode: 'Currency_code'
      @UI.lineItem: [{position:40}]
      @UI.identification: [{position:60}]
      booking_fee,
      @Semantics.amount.currencyCode: 'Currency_code'
      @UI.lineItem: [{position:50}]
      @UI.identification: [{position:70}]
      total_price,
      @UI.lineItem: [{position:60}]
      @UI.identification: [{position:80}]
      currency_code,
      @UI.identification: [{position:90}]
      description,
      @UI.lineItem: [{position:70}]
      @UI.identification: [{position:100}]
      status,
      createdby,
      createdat,
      lastchangedby,
      lastchangedat,
      /* Associations */
      _agency,
      _booking : redirected to composition child zm_proj_booking,
      _customer
}
