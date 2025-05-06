CLASS zamdp_demo DEFINITION
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
    METHODS get_data
      IMPORTING VALUE(bp)      TYPE zde_id
      EXPORTING VALUE(et_data) TYPE it_data.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zamdp_demo IMPLEMENTATION.
  METHOD get_data BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING zbp_table.
    et_data = select bo_id, bp_role, company_name from zbp_table where bo_id = :bp;
  ENDMETHOD.
  METHOD if_oo_adt_classrun~main.
    TYPES : BEGIN OF ty_data,
              bo_id        TYPE zde_id,
              bp_role      TYPE zde_role,
              company_name TYPE string,
            END OF ty_data.
    DATA: lt_data TYPE TABLE OF ty_data.
    DATA: p_bp TYPE zde_id.
    me->get_data(
    EXPORTING
    bp = 'LgR56Spm7j{}ew6N3DpXGG'
    IMPORTING
    et_data = lt_data
    ).

    out->write(
    EXPORTING
        data   = lt_data
*      name   =
*    RECEIVING66
*      output =
     ).
  ENDMETHOD.
ENDCLASS.
