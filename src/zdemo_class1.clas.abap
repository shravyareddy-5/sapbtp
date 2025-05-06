CLASS zdemo_class1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces IF_OO_ADT_CLASSRUN.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zdemo_class1 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
select * from zbp_table into @data(lt_table).
  OUT->write(
    EXPORTING
      data   = lt_table
*      name   =
*    RECEIVING
*      output =
  ).
  ENDSELECT.
  ENDMETHOD.

ENDCLASS.
