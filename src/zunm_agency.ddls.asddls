@AbapCatalog.sqlViewName: 'ZUNMGNCY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'unmanaged RAP Agency details'
@Metadata.ignorePropagatedAnnotations: true
define view zunm_agency as select from /dmo/agency association[1] to  I_Country as _country
on $projection.ACountryCode = _country.Country
{
 key agency_id as AgencyId,
 @Semantics.text: true
 name as AgencyName,
 street as AStreet,
 postal_code as APostalCode,
 city as ACity,
 country_code as ACountryCode,
 phone_number as APhoneNumber,
 email_address as AEmailAddress,
 web_address as AWebAddress,
  _country
}
