@AbapCatalog.sqlViewName: 'ZSQLBP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'business partner'
@Metadata.ignorePropagatedAnnotations: true
define view zcds_i_bp as select from zbp_table
{
    key bo_id,
    key bp_role,
    city,
    country,
    region
}
