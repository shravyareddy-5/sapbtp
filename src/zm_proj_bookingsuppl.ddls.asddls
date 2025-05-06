@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection view for booking suppliments'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo.typeNamePlural: 'BookingSuppl'
@Search.searchable: true
define view entity zm_proj_bookingsuppl as projection on zm_i_booking_suppl
{
@UI.facet: [{ id:'BookingS',
purpose:#STANDARD,
 type:#IDENTIFICATION_REFERENCE,
 label:'BookingSupply',
 position:10}]

 @UI.lineItem: [{position:10}]
 @UI.identification: [{position:10}]
 @Search.defaultSearchElement: true
    key travel_id,
     @UI.lineItem: [{position:20}]
     @UI.identification: [{position:20}]
    key booking_id,
     @UI.lineItem: [{position:30}]
     @UI.identification: [{position:30}]
    key booking_supplement_id,
     @UI.lineItem: [{position:40}]
     @UI.identification: [{position:40}]
    supplement_id,
    @Semantics.amount.currencyCode: 'currency_code'
     @UI.lineItem: [{position:50}]
     @UI.identification: [{position:50}]
    Price,
     @UI.lineItem: [{position:60}]
     @UI.identification: [{position:60}]
    currency_code,
    last_changed_at,
    /* Associations */
    _BOOKING : redirected to parent zm_proj_booking,
    _PRODUCT,
    _SUPPLEMENTTEXT,
    _TRAVEL
}
