@AbapCatalog.sqlViewName: 'ZSQLASSOC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'association table'
@Metadata.ignorePropagatedAnnotations: true
define view zcds1_i_sales
  as select from zso_item_table
  association [1] to zcds_p_product as _products on $projection.product = _products.product_id
  association [1] to zcds_so_bp     as _saleshdr on $projection.order_id = _saleshdr.order_id
{
  key item_id,
      order_id,
      product,
      _saleshdr.order_no,
      _products.name         as productname,
      _products.category         as category,
      qty,
      uom,
      currency,
      amount,
      _saleshdr._BP.company_name as companyname,
      _saleshdr._BP.region       as region,
      _saleshdr._BP.country      as country

}
