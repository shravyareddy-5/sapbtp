@AbapCatalog.sqlViewName: 'ZSQLBKNG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'managed booking scenario'
@Metadata.ignorePropagatedAnnotations: true
define view zm_i_booking as select from /dmo/booking as booking association to parent zm_i_travel  as _travel
on $projection.travel_id = _travel.travel_id
composition[0..*] of zm_i_booking_suppl as _BOOKINGSUPPL
association[1..1] to /DMO/I_Customer as _customer on $projection.customer_id = _customer.CustomerID
association[1..1] to /DMO/I_Carrier as _carrier on $projection.carrier_id = _carrier.AirlineID
association[1..1] to /DMO/I_Connection as _connection on $projection.carrier_id = _connection.AirlineID
and $projection.connection_id = _connection.ConnectionID
{
    key travel_id ,
    key booking_id ,
    booking_date ,
    customer_id ,
    carrier_id ,
    connection_id ,
    flight_date,
    flight_price ,
    currency_code ,
    _travel.lastchangedat,
    _customer,
    _carrier,
    _connection,
    _travel,
    _BOOKINGSUPPL
}
