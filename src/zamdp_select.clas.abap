CLASS zamdp_select DEFINITION
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
    TYPES : it_data TYPE TABLE OF ty_data.
    CLASS-METHODS get_data
      IMPORTING VALUE(iv_where) TYPE string
      EXPORTING VALUE(et_data)  TYPE it_data.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zamdp_select IMPLEMENTATION.
  METHOD get_data BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING zbp_table.
    itab = APPLY_FILTER ( zbp_table, :iv_where );
    et_data = select bo_id, bp_role, company_name from :itab;
  ENDMETHOD.
  METHOD if_oo_adt_classrun~main.
    TYPES : BEGIN OF ty_data,
              bo_id        TYPE zde_id,
              bp_role      TYPE zde_role,
              company_name TYPE string,
            END OF ty_data.
    DATA : tt_data TYPE TABLE OF ty_data.
    DATA : p_where TYPE string.
    me->get_data(
    EXPORTING
    iv_where = p_where
    IMPORTING
    et_data = tt_data
     ).
    out->write(
    EXPORTING
       data   = tt_data
*      name   =
*    RECEIVING
*      output =
      ).

  ENDMETHOD.

ENDCLASS.
