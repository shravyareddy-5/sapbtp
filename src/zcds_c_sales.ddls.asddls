@AbapCatalog.sqlViewName: 'ZSQLCON'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'consumption view'
@Metadata.ignorePropagatedAnnotations: true
define view zcds_c_sales as select from zcds1_i_sales
{
    key productname,
    sum(amount) as totalsales,
    currency
} group by productname,currency
