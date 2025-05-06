CLASS zclass_new_opensql DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zclass_new_opensql IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
select product_id, role, name, category, price, currency, discount
 from zprod_table
 where discount > 2
into @data(lt_table).
ENDSELECT.
out->write(
  EXPORTING
    data   =  lt_table
*    name   =
*  RECEIVING
*    output =
).
  ENDMETHOD.

ENDCLASS.
