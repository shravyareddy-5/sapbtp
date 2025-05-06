CLASS zcons_odata_s4 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    INTERFACES if_rap_query_provider.
    TYPES: it_business_data TYPE TABLE OF zodata_consum_model=>tys_sepmra_i_product_etype.
    METHODS get_data
      EXPORTING VALUE(et_data) TYPE it_business_data.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcons_odata_s4 IMPLEMENTATION.

  METHOD get_data.
    DATA:
      it_business_data TYPE TABLE OF zodata_consum_model=>tys_sepmra_i_product_etype,
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
      lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.
    TRY.
* Create http client
        DATA(lo_destination) = cl_http_destination_provider=>create_by_url(
        i_url = 'https://sapes5.sapdevcenter.com' ).
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination(
        lo_destination ).
        lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
        EXPORTING
           is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                               proxy_model_id      = 'ZODATA_CONSUM_MODEL'
                                               proxy_model_version = '0001' )
          io_http_client             = lo_http_client
          iv_relative_service_root   = '/sap/opu/odata/sap/ZPDCDS_SRV/' ).

        ASSERT lo_http_client IS BOUND.


        " Navigate to the resource and create a request for the read operation
        lo_request = lo_client_proxy->create_resource_for_entity_set( 'SEPMRA_I_PRODUCT_E' )->create_request_for_read( ).

        " Create the filter tree
*lo_filter_factory = lo_request->create_filter_factory( ).
*
*lo_filter_node_1  = lo_filter_factory->create_by_range( iv_property_path     = 'PRODUCT'
*                                                        it_range             = lt_range_PRODUCT ).
*lo_filter_node_2  = lo_filter_factory->create_by_range( iv_property_path     = 'PRODUCT_TYPE'
*                                                        it_range             = lt_range_PRODUCT_TYPE ).

*lo_filter_node_root = lo_filter_node_1->and( lo_filter_node_2 ).
*lo_request->set_filter( lo_filter_node_root ).

        lo_request->set_top( 50 )->set_skip( 0 ).

        " Execute the request and retrieve the business data
        lo_response = lo_request->execute( ).
        lo_response->get_business_data( IMPORTING et_business_data = it_business_data ).

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection

      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception

      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        " Handle Exception
        RAISE SHORTDUMP lx_web_http_client_error.
      CATCH cx_http_dest_provider_error.
        "handle exception
    ENDTRY.
    et_data = it_business_data.
  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.

    DATA: it_business_data TYPE TABLE OF zodata_consum_model=>tys_sepmra_i_product_etype.
    me->get_data(
    IMPORTING
    et_data = it_business_data
     ).
    out->write(
    EXPORTING
    data   =  it_business_data
*    name   =
*  RECEIVING
*    output =
    ).

  ENDMETHOD.

  METHOD if_rap_query_provider~select.
    DATA:
      it_business_data TYPE TABLE OF zodata_consum_model=>tys_sepmra_i_product_etype,
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
      lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.
    TRY.
*Create http client
        DATA(lo_paging) = io_request->get_paging( ).
        DATA(lv_top) = lo_paging->get_page_size( ).
        DATA(lv_skip) = lo_paging->get_offset( ).

        DATA(lo_destination) = cl_http_destination_provider=>create_by_url(
        i_url = 'https://sapes5.sapdevcenter.com' ).
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination(
        lo_destination ).
        lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
        EXPORTING
        is_proxy_model_key = VALUE #( repository_id = 'default'
        proxy_model_id = 'zodata_consum_model'
        proxy_model_version = '0001' )
        io_http_client = lo_http_client
        iv_relative_service_root = '/sap/opu/odata/sap/ZPDCDS_SRV' ).
        ASSERT lo_http_client IS BOUND.
*         Navigate to the resource and create a request for the read operation
        lo_request = lo_client_proxy->create_resource_for_entity_set(
        'SEPMRA_I_PRODUCT_E' )->create_request_for_read( ).

*        io_request->get_paging(
*        RECEIVING
*        ro_paging = DATA(lo_paging)
*        ).
*        DATA(lo_paging) = io_request->get_paging( ).
*        DATA(lv_top) = lo_paging->get_page_size( ).
*        DATA(lv_skip) = lo_paging->get_offset( ).
        lo_request->set_top( CONV #( lv_top ) )->set_skip( CONV #( lv_skip ) ).
* Execute the request and retrieve the business data
        lo_response = lo_request->execute( ).
        lo_response->get_business_data( IMPORTING et_business_data =
        it_business_data ).
      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
* Handle remote Exception
* It contains details about the problems of your http(s) connection
      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
*Handle Exception
      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
* Handle Exception
        RAISE SHORTDUMP lx_web_http_client_error.
    ENDTRY.
*delete business_data where currency NE &#39;EUR&#39;.

    io_response->set_total_number_of_records( lines( it_business_data ) ).
    io_response->set_data( it_business_data ).
  ENDMETHOD.

ENDCLASS.
