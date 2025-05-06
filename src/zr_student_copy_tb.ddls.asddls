@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_STUDENT_COPY_TB
  as select from ZSTUDENT_COPY_TB
{
  key id as Id,
  firstname as Firstname,
  lastname as Lastname,
  age as Age,
  course as Course,
  courseduration as Courseduration,
  status as Status,
  gender as Gender,
  dob as Dob,
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  lastchangedat as Lastchangedat,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy
  
}
