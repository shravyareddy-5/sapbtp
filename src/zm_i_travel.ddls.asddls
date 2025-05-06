@AbapCatalog.sqlViewName: 'ZMTRAVEL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'managed travel details'
@Metadata.ignorePropagatedAnnotations: true
define root view zm_i_travel as select from /dmo/travel as travel composition[0..*] of zm_i_booking as _booking
association[1] to /dmo/agency as _agency on $projection.agency_id = _agency.agency_id
association[1] to /dmo/customer as _customer on $projection.customer_id = _customer.customer_id
{
    key travel_id ,
    agency_id,
    customer_id ,
    begin_date,
    end_date ,
    booking_fee ,
    total_price ,
    currency_code ,
    description ,
    status ,
    @Semantics.user.createdBy: true
    createdby ,
    @Semantics.systemDateTime.createdAt: true
    createdat,
    @Semantics.user.lastChangedBy: true
    lastchangedby ,
    @Semantics.systemDateTime.lastChangedAt: true
    lastchangedat ,
    _agency,
    _customer,
    _booking
}
