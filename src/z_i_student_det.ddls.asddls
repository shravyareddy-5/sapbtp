@AbapCatalog.sqlViewName: 'ZSTUDENTDET'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'interfacse view for student details'
@Metadata.ignorePropagatedAnnotations: true
define root view z_i_student_det as select from zstudent_btp_tab 
composition [1..*] of z_i_student_attach as _attachments
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
   lastchangedat as Lastchangedat,
   locallastchangedat as Locallastchangedat, 
   
   _attachments
}
