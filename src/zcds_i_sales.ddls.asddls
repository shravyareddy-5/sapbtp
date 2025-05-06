@AbapCatalog.sqlViewName: 'ZSQLSALES'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'sales order association'
@Metadata.ignorePropagatedAnnotations: true
define view zcds_i_sales as select from zso_item_table association[1] to zso_hdr_table as _saleshdr on
$projection.order_id = _saleshdr.order_id
{
  key item_id,
  order_id ,
  product,
  qty,
  uom,
  amount,
  currency,
  _saleshdr 
}
