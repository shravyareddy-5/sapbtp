CLASS lhc_booking DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS calculateTotalFlightPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR booking~calculateTotalFlightPrice.

ENDCLASS.

CLASS lhc_booking IMPLEMENTATION.

  METHOD calculateTotalFlightPrice.
    READ ENTITY zm_i_booking FROM VALUE #( FOR keyval IN keys ( %key  = keyval-%key
        %control-booking_id = if_abap_behv=>mk-on
        %control-flight_price = if_abap_behv=>mk-on
        %control-currency_code = if_abap_behv=>mk-on )  ) RESULT DATA(lt_booking).

    LOOP AT lt_booking INTO DATA(ls_booking).

      " Get related flight prices
      SELECT SUM( flight_price ) AS total_price
        FROM zm_i_booking
        WHERE booking_id = @ls_booking-booking_id
         INTO @DATA(lv_total_price).

      " Prepare update table
      MODIFY  ENTITY zm_i_booking
        UPDATE FROM VALUE #(
          ( booking_id = ls_booking-booking_id
            flight_price = lv_total_price
            %control-flight_price = if_abap_behv=>mk-on )
        ).
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_TRAVEL DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR travel RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR travel RESULT result.
    METHODS createtravelbytemplate FOR MODIFY
      IMPORTING keys FOR ACTION travel~createtravelbytemplate RESULT result.
    METHODS approvetravel FOR MODIFY
      IMPORTING keys FOR ACTION travel~approvetravel RESULT result.

    METHODS rejecttravel FOR MODIFY
      IMPORTING keys FOR ACTION travel~rejecttravel RESULT result.

*    METHODS validatestatus FOR VALIDATE ON SAVE
*      IMPORTING keys FOR travel~validatestatus.

ENDCLASS.

CLASS lhc_TRAVEL IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_instance_features.

    READ ENTITY zm_i_travel FROM VALUE #( FOR keyval IN keys ( %key  = keyval-%key
    %control-travel_id = if_abap_behv=>mk-on
    %control-status = if_abap_behv=>mk-on )  ) RESULT DATA(lt_travel).

    result = VALUE #( FOR ls_travel IN lt_travel ( %key = ls_travel-%key
    %field-travel_id = if_abap_behv=>fc-f-read_only

    %features-%action-approveTravel = COND #( WHEN ls_travel-status = 'A' THEN if_abap_behv=>fc-o-disabled
    ELSE if_abap_behv=>fc-o-enabled  )
     %features-%action-rejectTravel = COND #( WHEN ls_travel-status = 'X' THEN if_abap_behv=>fc-o-disabled
    ELSE if_abap_behv=>fc-o-enabled  )
    ) ).

  ENDMETHOD.

  METHOD createTravelbyTemplate.
    SELECT MAX( travel_id ) FROM /dmo/travel INTO @DATA(lv_travel_id).


    READ ENTITY zm_i_travel FROM VALUE #( FOR keyval IN keys ( %key  = keyval-%key
    %control-travel_id = if_abap_behv=>mk-on
    %control-agency_id = if_abap_behv=>mk-on
    %control-customer_id = if_abap_behv=>mk-on
    %control-begin_date = if_abap_behv=>mk-on
    %control-booking_fee = if_abap_behv=>mk-on
    %control-currency_code = if_abap_behv=>mk-on
    %control-description = if_abap_behv=>mk-on
    %control-total_price = if_abap_behv=>mk-on )  )
    RESULT DATA(lt_travel).

    DATA(lv_today) = cl_abap_context_info=>get_system_date(  ).
    DATA lt_create TYPE TABLE FOR CREATE zm_i_travel.
    lt_create = VALUE #( FOR row IN lt_travel INDEX INTO idx (
    travel_id = lv_travel_id + 1
    agency_id = row-agency_id
    customer_id = row-customer_id
    begin_date = lv_today
    booking_fee = row-booking_fee
    currency_code = row-currency_code
    description = 'Test'
    total_price = row-total_price
    %control  = VALUE #(
    travel_id = if_abap_behv=>mk-on
    agency_id = if_abap_behv=>mk-on
    customer_id = if_abap_behv=>mk-on
    booking_fee = if_abap_behv=>mk-on
    begin_date = if_abap_behv=>mk-on
    currency_code = if_abap_behv=>mk-on
    description = if_abap_behv=>mk-on
    total_price = if_abap_behv=>mk-on

  )
   ) ).

    MODIFY ENTITIES OF zm_i_travel ENTITY zm_i_travel
    CREATE FROM lt_create
    MAPPED mapped
    FAILED failed
    REPORTED reported.

    result = VALUE #( FOR created IN lt_create INDEX INTO idx ( %cid_ref = keys[ idx ]-%cid_ref
    %key = keys[ idx ]-%key
    %param = CORRESPONDING #( created ) ) ).

  ENDMETHOD.

  METHOD approveTravel.
    MODIFY ENTITIES OF zm_i_travel ENTITY zm_i_travel
    UPDATE FROM VALUE #( FOR key IN keys ( travel_id = key-travel_id
    status = 'A'
     %control-status = if_abap_behv=>mk-on  ) ).

    READ ENTITY zm_i_travel FROM VALUE #( FOR key IN keys ( travel_id = key-travel_id
    %control = VALUE #(
    travel_id = if_abap_behv=>mk-on
       agency_id = if_abap_behv=>mk-on
       customer_id = if_abap_behv=>mk-on
       booking_fee = if_abap_behv=>mk-on
       begin_date = if_abap_behv=>mk-on
       currency_code = if_abap_behv=>mk-on
       description = if_abap_behv=>mk-on
       total_price = if_abap_behv=>mk-on
    )
    ) ) RESULT DATA(lt_travel).

    result = VALUE #( FOR lw_travel IN lt_travel (  travel_id = lw_travel-travel_id
    %param = lw_travel ) ).
  ENDMETHOD.

  METHOD rejectTravel.
    MODIFY ENTITIES OF zm_i_travel ENTITY zm_i_travel
       UPDATE FROM VALUE #( FOR key IN keys ( travel_id = key-travel_id
       status = 'X'
        %control-status = if_abap_behv=>mk-on  ) ).

    READ ENTITIES OF zm_i_travel ENTITY zm_i_travel FROM VALUE #( FOR key IN keys ( travel_id = key-travel_id
    %control = VALUE #(
    travel_id = if_abap_behv=>mk-on
       agency_id = if_abap_behv=>mk-on
       customer_id = if_abap_behv=>mk-on
       booking_fee = if_abap_behv=>mk-on
       begin_date = if_abap_behv=>mk-on
       currency_code = if_abap_behv=>mk-on
       description = if_abap_behv=>mk-on
       total_price = if_abap_behv=>mk-on
    )

    ) ) RESULT DATA(lt_travel).

    result = VALUE #( FOR lw_travel IN lt_travel (  travel_id = lw_travel-travel_id
    %param = lw_travel ) ).
  ENDMETHOD.

*  METHOD validateStatus.
*    READ ENTITY zm_i_travel FROM VALUE #( FOR key IN keys ( %key  = key-%key
*      %control = VALUE #( status = if_abap_behv=>mk-on ) ) )
*      RESULT DATA(lt_travel).
*
*    LOOP AT lt_travel INTO DATA(ls_travel).
*      CASE ls_travel-status.
*        WHEN 'O'. WHEN 'A'. WHEN 'X'.
*        continue.
*        WHEN OTHERS.
*          APPEND VALUE #( %key = ls_travel-%key ) TO failed.
*          APPEND VALUE #( %key = ls_travel-%key
*                          %msg = new-message
*                          id = /dmo/cx_flight_legacy=>status_is_not_valid-msgid
*                          number = /dmo/cx_flight_legacy=>status_is_not_valid-msgno
*                          severity = if_abap_behv_message=>severity-error
*                          )  to reported .
*      ENDCASE.
*    ENDLOOP.
*  ENDMETHOD.

ENDCLASS.
