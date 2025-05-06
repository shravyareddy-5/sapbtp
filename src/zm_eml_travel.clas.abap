CLASS zm_eml_travel DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES  if_oo_adt_classrun.
  data  lv_type type c  value 'D'.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zm_eml_travel IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
data : it_table_create type table for create zm_i_travel.
if lv_type = 'C'.
it_table_create = value #( (
travel_id = '00009999'
agency_id = 70003
customer_id = 2
begin_date = cl_abap_context_info=>get_system_date( )
end_date = cl_abap_context_info=>get_system_date( ) + 30
booking_fee = 50
total_price = 5000
currency_code = 'USD'
status = 'P'
description = 'WW'
%control = value #( agency_id = if_abap_behv=>mk-on
travel_id = if_abap_behv=>mk-on
customer_id = if_abap_behv=>mk-on
begin_date = if_abap_behv=>mk-on
end_date = if_abap_behv=>mk-on
booking_fee = if_abap_behv=>mk-on
total_price = if_abap_behv=>mk-on
currency_code = if_abap_behv=>mk-on
status = if_abap_behv=>mk-on
description = if_abap_behv=>mk-on

 )
)

 ).
 MODIFY entities of zm_i_travel entity travel create from it_table_create
 failed data(lt_failed)
 reported data(lt_reported).
 if lt_failed is not initial.
 out->write(
   EXPORTING
     data   = lt_failed
*     name   =
*   RECEIVING
*     output =
 ).
 endif.

 elseif lv_type = 'U'.
 data : it_table_update type table for update zm_i_travel.

it_table_update = value #( (
travel_id = '00009999'

description = 'WWWW'
%control = value #(

description = if_abap_behv=>mk-on

 )
)

 ).
 MODIFY entities of zm_i_travel entity travel update from it_table_update
 failed lt_failed
 reported lt_reported.
 if lt_failed is not initial.
 out->write(
   EXPORTING
     data   = lt_failed
*     name   =
*   RECEIVING
*     output =
 ).
 endif.
 elseif lv_type = 'D'.
 data : it_table_delete type table for delete zm_i_travel.

it_table_delete = value #( (
travel_id = '00009999'

)

 ).
 MODIFY entities of zm_i_travel entity travel delete from it_table_delete
 failed lt_failed
 reported lt_reported.
 if lt_failed is not initial.
 out->write(
   EXPORTING
     data   = lt_failed
*     name   =
*   RECEIVING
*     output =
 ).
 endif.
 elseif lv_type = 'R'.
read entities of zm_i_travel entity Travel from
VALUE #( (
travel_id = '00009999'
%control = VALUE #(
customer_id = if_abap_behv=>mk-on
begin_date = if_abap_behv=>mk-on
end_date = if_abap_behv=>mk-on
description = if_abap_behv=>mk-on
booking_fee = if_abap_behv=>mk-on
total_price = if_abap_behv=>mk-on
currency_code = if_abap_behv=>mk-on
status = if_abap_behv=>mk-on )
) )
result data(lt_found_records).
if lt_found_records is not initial.
out->write(
exporting data = lt_found_records ).
endif.
 endif.
 commit entities.
  ENDMETHOD.

ENDCLASS.
