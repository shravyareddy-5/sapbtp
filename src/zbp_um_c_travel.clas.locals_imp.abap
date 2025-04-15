CLASS lhc_zum_c_travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zum_c_travel RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE zum_c_travel.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zum_c_travel.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zum_c_travel.

    METHODS read FOR READ
      IMPORTING keys FOR READ zum_c_travel RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zum_c_travel.

    METHODS map_data
      IMPORTING im_data            TYPE zum_c_travel
      RETURNING VALUE(r_bapi_data) TYPE /dmo/s_travel_in.


ENDCLASS.

CLASS lhc_zum_c_travel IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.
  METHOD map_data.
    r_bapi_data-agency_id = im_data-AgencyId.
    r_bapi_data-begin_date = im_data-BeginDate.
    r_bapi_data-booking_fee = im_data-BookingFee.
    r_bapi_data-currency_code = im_data-CurrencyCode.
    r_bapi_data-customer_id = im_data-CustomerId.
    r_bapi_data-description = im_data-Description.
    r_bapi_data-end_date = im_data-EndDate.
    r_bapi_data-status = im_data-Status.
    r_bapi_data-total_price = im_data-TotalPrice.

  ENDMETHOD.
  METHOD create.
    DATA : ls_travel_in  TYPE /dmo/s_travel_in,
           ls_travel_out TYPE /dmo/travel,
           lt_messages   TYPE /dmo/t_message.
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_create>).
      ls_travel_in = map_data( im_data = CORRESPONDING #( <fs_create> ) ).
      CALL FUNCTION '/DMO/FLIGHT_TRAVEL_CREATE'
        EXPORTING
          is_travel   = ls_travel_in
        IMPORTING
          es_travel   = ls_travel_out
          et_messages = lt_messages.
      IF lt_messages IS INITIAL.
        INSERT VALUE #( %cid = <fs_create>-%cid
        travelid = ls_travel_out-travel_id ) INTO TABLE mapped-zum_c_travel.
      ELSE.
        LOOP AT lt_messages TRANSPORTING NO FIELDS WHERE msgty = 'E' OR msgty = 'A'.
          ls_travel_in = map_data( im_data = CORRESPONDING #( <fs_create> ) ).
          INSERT VALUE #( %cid = <fs_create>-%cid ) INTO TABLE failed-zum_c_travel.
        ENDLOOP.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD update.
    DATA : ls_travel_in TYPE /dmo/s_travel_in,
           Ls_travel_x  TYPE /dmo/s_travel_inx,
           lt_messages  TYPE /dmo/t_message.
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_update>).
      ls_travel_in = map_data( im_data = CORRESPONDING #( <fs_update> ) ).
      ls_travel_x-agency_id  = xsdbool( <fs_update>-%control-AgencyId = cl_abap_behv=>flag_changed ) .
      ls_travel_x-begin_date  = xsdbool( <fs_update>-%control-BeginDate = cl_abap_behv=>flag_changed ).
      ls_travel_x-booking_fee  = xsdbool( <fs_update>-%control-BookingFee = cl_abap_behv=>flag_changed ).
      ls_travel_x-currency_code  = xsdbool( <fs_update>-%control-CurrencyCode = cl_abap_behv=>flag_changed ).
      ls_travel_x-customer_id  = xsdbool( <fs_update>-%control-CustomerId = cl_abap_behv=>flag_changed ).
      ls_travel_x-description  = xsdbool( <fs_update>-%control-Description = cl_abap_behv=>flag_changed ).
      ls_travel_x-end_date  = xsdbool( <fs_update>-%control-EndDate = cl_abap_behv=>flag_changed ).
      ls_travel_x-status  = xsdbool( <fs_update>-%control-Status = cl_abap_behv=>flag_changed ).
      ls_travel_x-total_price  = xsdbool( <fs_update>-%control-TotalPrice = cl_abap_behv=>flag_changed ).
      ls_travel_in-travel_id = <fs_update>-TravelId.
      ls_travel_x-travel_id = <fs_update>-TravelId.

      CALL FUNCTION '/DMO/FLIGHT_TRAVEL_UPDATE'
        EXPORTING
          is_travel   = ls_travel_IN
          is_travelx  = ls_travel_x
        IMPORTING
          et_messages = lt_messages.
      LOOP AT lt_messages TRANSPORTING NO FIELDS WHERE msgty = 'E' OR msgty = 'A'.

        INSERT VALUE #( travelid = <fs_update>-TravelId
        %cid = <fs_update>-%cid_ref )
        INTO TABLE failed-zum_c_travel .
      ENDLOOP.

    ENDLOOP.

  ENDMETHOD.

  METHOD delete.
    DATA : lt_messages  TYPE /dmo/t_message,
           lv_travel_id TYPE /dmo/travel_id.

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<fs_delete>).
      lv_travel_id = <fs_delete>-TravelId.
      CALL FUNCTION '/DMO/FLIGHT_TRAVEL_DELETE'
        EXPORTING
          iv_travel_id = lv_travel_id
        IMPORTING
          et_messages  = lt_messages.
      LOOP AT lt_messages TRANSPORTING NO FIELDS WHERE msgty = 'E' OR msgty = 'A'.
        INSERT VALUE #( %cid = <fs_delete>-%cid_ref
        travelid = <fs_delete>-TravelId  ) INTO TABLE failed-zum_c_travel.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZUM_C_TRAVEL DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZUM_C_TRAVEL IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.

    CALL FUNCTION '/DMO/FLIGHT_TRAVEL_SAVE'.

  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
