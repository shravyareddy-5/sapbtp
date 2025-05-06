@AbapCatalog.sqlViewName: 'ZSTUATTACH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'interface view for student attachments'
@Metadata.ignorePropagatedAnnotations: true
define view z_i_student_attach as select from zstudent_attach
association to parent z_i_student_det as _student
on $projection.Id = _student.Id
{
   key attach_id,
   id as Id,
   comments as Comments,
   attachment as Attachment,
   mimetype as Mimetype,
   filename as Filename ,
   _student.Lastchangedat, 
   _student
}
