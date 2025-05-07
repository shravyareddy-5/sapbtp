@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection view for student details'
@Metadata.ignorePropagatedAnnotations: true
define root view entity z_proj_student as projection on z_i_student_det
{
 @UI.facet: [{ id:'StudentData',
      purpose:#STANDARD,
       type:#IDENTIFICATION_REFERENCE,
       label:'Student Data',
       position:10},
       {
       id:'Upload',
      purpose:#STANDARD,
       type:#LINEITEM_REFERENCE,
       label:'Upload Attachments',
       position:20,
       targetElement:'_attachments'
       }]
@UI.lineItem: [{position:10  }]
@UI.identification: [{position:10  }]
    key Id,
    @UI.lineItem: [{position:20  }]
    @UI.identification: [{position:20  }]
    Firstname,
    @UI.lineItem: [{position:30  }]
    @UI.identification: [{position:30  }]
    Lastname,
    @UI.lineItem: [{position:40  }]
    @UI.identification: [{position:40  }]
    Age,
    @UI.lineItem: [{position:50  }]
    @UI.identification: [{position:50  }]
    Course,
    @UI.lineItem: [{position:60  }]
    @UI.identification: [{position:60  }]
    Courseduration,
    @UI.lineItem: [{position:70  }]
    @UI.identification: [{position:70  }]
    Status,
    @UI.lineItem: [{position:80  }]
    @UI.identification: [{position:80  }]
    Gender,
    @UI.lineItem: [{position:90  }]
    @UI.identification: [{position:90  }]
    Dob,
    Lastchangedat,
    Locallastchangedat,
    /* Associations */
    _attachments : redirected to composition child zproj_stu_attach
}
