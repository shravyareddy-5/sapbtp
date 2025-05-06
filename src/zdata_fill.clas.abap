CLASS zdata_fill DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS fill_master_data
              RAISING
                cx_uuid_error.
    METHODS flush.
    METHODS fill_transaction_data.
ENDCLASS.



CLASS zdata_fill IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    me->flush( ).
    me->fill_master_data( ).
    me->fill_transaction_data( ).
  ENDMETHOD.

  METHOD fill_master_data.
    DATA: lt_bp   TYPE TABLE OF zbp_table,
          lt_prod TYPE TABLE OF zprod_table.

    APPEND VALUE #( bo_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c22( )
    bp_role = '01'
    company_name = 'Infosys'
    city = 'Hyderabad'
    street = 'Ameerpet'
    country = 'IN'
    region = 'SI') TO lt_bp.
    APPEND VALUE #( bo_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c22( )
    bp_role = '02'
    company_name = 'Infosys'
    city = 'Hyderabad'
    street = 'Ameerpet'
    country = 'IN'
    region = 'SI') TO lt_bp.
    APPEND VALUE #( product_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
    role = '01'
    name = 'HP Laptop'
    price = 125
    currency = 'INR'
    discount = 2 ) TO lt_prod.
    APPEND VALUE #( product_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
    role = '02'
    name = 'Dell Laptop'
    price = 125
    currency = 'INR'
    discount = 2 ) TO lt_prod.
    INSERT zbp_table FROM TABLE @lt_bp.
    INSERT zprod_table FROM TABLE @lt_prod.
  ENDMETHOD.

  METHOD fill_transaction_data.
    DATA :o_rand  TYPE REF TO cl_abap_random_int,
          n       TYPE i,
          seed    TYPE i,
          lt_so   TYPE TABLE OF zso_hdr_table,
          lt_so_i TYPE TABLE OF zso_item_table,
          lv_date TYPE timestamp.
    seed = cl_abap_random=>seed( ).
    cl_abap_random_int=>create( EXPORTING
    seed = seed
    min = 1
    max = 2
    RECEIVING
    prng = o_rand ).
    SELECT * FROM zbp_table INTO TABLE @DATA(lt_bp).
    SELECT * FROM zprod_table INTO TABLE @DATA(lt_prod).
    DO 10 TIMES.
      DATA(lv_ord_id) = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( ).
      n = o_rand->get_next( ).
      READ TABLE lt_bp INTO DATA(ls_bp) INDEX n.
      APPEND VALUE #( order_id = lv_ord_id
      order_no = sy-index
      buyer = ls_bp-bo_id
      gross_amount = n * 100
      currency = 'INR'
      created_by = sy-uname
      created_on = lv_date
      changed_by = sy-uname
      changed_on = lv_date ) TO lt_so.
      DO 2 TIMES .
        READ TABLE lt_prod INTO DATA(ls_product) INDEX n.
        n = o_rand->get_next( ).
        APPEND VALUE #( order_id = lv_ord_id
        item_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
        product = ls_product-product_id
        qty = n
        uom = 'PC'
        amount = n * ls_product-price
        currency = 'INR'
        created_by = sy-uname
        created_on = lv_date
        changed_by = sy-uname
        changed_on = lv_date
        ) TO lt_so_i.
      ENDDO.
    ENDDO.
    INSERT zso_hdr_table FROM TABLE @lt_so.
    INSERT zso_item_table FROM TABLE @lt_so_i.
  ENDMETHOD.

  METHOD flush.
    DELETE FROM : zbp_table,zprod_table,zso_hdr_table,zso_item_table.
  ENDMETHOD.

ENDCLASS.
