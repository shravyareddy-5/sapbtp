@AbapCatalog.sqlViewName: 'ZSQLSBP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'sales and bp'
@Metadata.ignorePropagatedAnnotations: true
define view zcds_so_bp as select from zso_hdr_table association[1] to zbp_table as _BP on
$projection.buyer = _BP.bp_role

{
  key order_id,
  order_no,
  buyer,
  gross_amount,
  currency,
  _BP   
}
