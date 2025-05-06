@AbapCatalog.sqlViewName: 'ZSQLPROD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'products table view'
@Metadata.ignorePropagatedAnnotations: true
define view zcds_p_product as select from zprod_table
{
    key product_id,
    key role,
    name,
    currency,
    category,
    discount,
    price
}
