@AbapCatalog.sqlViewName: 'ZBKSUPPL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'managed booking suppliments'
@Metadata.ignorePropagatedAnnotations: true
define view zm_i_booking_suppl as select from /dmo/booksuppl_m as _BOOKINGSUPPL
association to parent zm_i_booking as _BOOKING on $projection.booking_id = _BOOKING.booking_id
and $projection.travel_id = _BOOKING.travel_id
association [1..1] to zm_i_travel as _TRAVEL on $projection.travel_id = _TRAVEL.travel_id
association[1..1] to /DMO/I_Supplement as _PRODUCT on $projection.supplement_id = _PRODUCT.SupplementID
association[1..1] to /DMO/I_SupplementText as _SUPPLEMENTTEXT on $projection.supplement_id = _SUPPLEMENTTEXT.SupplementID
{
  key travel_id ,
  key booking_id ,
  key booking_supplement_id ,
  supplement_id ,
  price as Price,
  currency_code ,
  last_changed_at,
  _TRAVEL,
  _PRODUCT,
  _SUPPLEMENTTEXT,
  _BOOKING
}
