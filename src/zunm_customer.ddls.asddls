@AbapCatalog.sqlViewName: 'ZUNCUST'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'unmanaged customer details'
@Metadata.ignorePropagatedAnnotations: true
define view zunm_customer as select from /dmo/customer association[1] to I_Country as _country
 on $projection.CountryCode = _country.Country 
{
    key customer_id as CustomerId,
    first_name as FirstName,
    last_name as LastName,
    @Semantics.text: true
    concat(first_name,last_name) as Name,
    title as Title,
    street as Street,
    postal_code as PostalCode,
    city as City,
    country_code as CountryCode,
    phone_number as phoneno,
    email_address as emailaddr,
    _country
    
}
