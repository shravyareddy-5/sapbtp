@AbapCatalog.sqlViewName: 'ZSQLPROD1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'products table view'
@Metadata.ignorePropagatedAnnotations: true
define view ZCDS_P_PRODUCT1 as select from zprod_table
{
    key product_id,
    key role,
    name,
    currency,
    category,
    discount,
    price
}
