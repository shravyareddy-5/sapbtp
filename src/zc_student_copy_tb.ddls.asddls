@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZC_STUDENT_COPY_TB
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_STUDENT_COPY_TB
{
  key Id,
  Firstname,
  Lastname,
  Age,
  Course,
  Courseduration,
  Status,
  Gender,
  Dob,
  LocalCreatedBy,
  LocalCreatedAt,
  Lastchangedat,
  LocalLastChangedAt,
  LocalLastChangedBy
  
}
