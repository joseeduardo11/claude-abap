CLASS lhc_travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS assignTravelID FOR DETERMINE ON SAVE
      IMPORTING keys FOR Travel~assignTravelID.
ENDCLASS.

CLASS lhc_travel IMPLEMENTATION.
  METHOD assignTravelID.
    " Read the Travel instances that were created
    READ ENTITIES OF zdmo_r_travel IN LOCAL MODE
      ENTITY Travel
        FIELDS ( TravelID )
        WITH CORRESPONDING #( keys )
      RESULT DATA(travels).

    " Only assign an ID to instances that do not have one yet
    DELETE travels WHERE TravelID IS NOT INITIAL.
    CHECK travels IS NOT INITIAL.

    " Determine the highest Travel ID already used in the active persistence
    SELECT SINGLE FROM zdmo_a_travel_d
      FIELDS MAX( travel_id ) AS travel_id
      INTO @DATA(max_travelid).

    " Assign consecutive Travel IDs
    DATA update TYPE TABLE FOR UPDATE zdmo_r_travel.
    LOOP AT travels INTO DATA(travel).
      max_travelid += 1.
      APPEND VALUE #( %tky     = travel-%tky
                      TravelID = max_travelid ) TO update.
    ENDLOOP.

    MODIFY ENTITIES OF zdmo_r_travel IN LOCAL MODE
      ENTITY Travel
        UPDATE FIELDS ( TravelID )
        WITH update
      REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).
  ENDMETHOD.
ENDCLASS.
