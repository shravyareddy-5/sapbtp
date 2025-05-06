@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection view for student attachments'
@Metadata.ignorePropagatedAnnotations: true
define view entity zproj_stu_attach as projection on z_i_student_attach
{
@UI.facet: [{ id:'StudentData',
      purpose:#STANDARD,
       type:#IDENTIFICATION_REFERENCE,
       label:'Attachment Information',
       position:10}]
@UI.lineItem: [{position:10  }]
@UI.identification: [{position:10  }]
    key attach_id,
    @UI.lineItem: [{position:20  }]
    @UI.identification: [{position:20  }]
    Id,
    @UI.lineItem: [{position:30  }]
    @UI.identification: [{position:30  }]
    Comments,
    @UI.lineItem: [{position:40  }]
    @UI.identification: [{position:40  }]
    Attachment,
    Mimetype,
    Filename,
    /* Associations */
    _student : redirected to parent z_proj_student
}
