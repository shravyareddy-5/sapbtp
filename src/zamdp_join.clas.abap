CLASS zamdp_join DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    INTERFACES if_amdp_marker_hdb.
    TYPES : BEGIN OF ty_data,
              bo_id        TYPE zde_id,
              bp_role      TYPE zde_role,
              company_name TYPE string,
            END OF ty_data.
    TYPES: it_data TYPE TABLE OF ty_data.
*    TYPES : p_bp TYPE zde_id.
    METHODS get_data
      EXPORTING VALUE(et_data) TYPE it_data.
    TYPES : BEGIN OF ty_data1,
              bo_id   TYPE zde_id,
              bp_role TYPE zde_role,
              buyer   TYPE zde_id,
            END OF ty_data1.
    TYPES: tt_data TYPE TABLE OF ty_data1.
*    TYPES : p_bp TYPE zde_id.
    METHODS get_details
      IMPORTING VALUE(bp)      TYPE zde_id
      EXPORTING VALUE(et_data) TYPE tt_data.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zamdp_join IMPLEMENTATION.
  METHOD get_data BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING zbp_table.
    et_data = select bo_id, bp_role, company_name  from zbp_table;
  ENDMETHOD.
  METHOD get_details  BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING zbp_table zso_hdr_table.
    et_data = select A.bo_id, A.bp_role, B.buyer
    from zbp_table as A inner join zso_hdr_table as B on A.bo_id = B.buyer where A.bo_id = bp;
  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.
    TYPES : BEGIN OF ty_data,
              bo_id        TYPE zde_id,
              bp_role      TYPE zde_role,
              company_name TYPE string,
            END OF ty_data.
    DATA: lt_data TYPE TABLE OF ty_data.
    me->get_data(
    IMPORTING
    et_data = lt_data
     ).
    out->write(
    EXPORTING
          data   = lt_data
*      name   =
*    RECEIVING
*      output =
    ).
    TYPES : BEGIN OF ty_data1,
              bo_id   TYPE zde_id,
              bp_role TYPE zde_role,
              buyer   TYPE zde_id,
            END OF ty_data1.
    DATA: lt_data1 TYPE TABLE OF ty_data1.
    DATA : p_bp TYPE zde_id.
    me->get_details(
    EXPORTING
    bp = p_bp
    IMPORTING
    et_data = lt_data1
    ).
    out->write(
      EXPORTING
            data   = lt_data1
*      name   =
*    RECEIVING
*      output =
    ).
  ENDMETHOD.

ENDCLASS.
