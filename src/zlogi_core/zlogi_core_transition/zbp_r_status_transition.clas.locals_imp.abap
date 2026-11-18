CLASS lhc_StatusTransition DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR StatusTransition RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR StatusTransition RESULT result.
    METHODS ValidateTransition FOR VALIDATE ON SAVE
      IMPORTING keys FOR StatusTransition~ValidateTransition.
    METHODS ValidateStatusExistence FOR VALIDATE ON SAVE
      keys FOR StatusTransition~ValidateStatusExistence.

ENDCLASS.

CLASS lhc_StatusTransition IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD ValidateTransition.

    READ ENTITIES OF zr_status_transition IN LOCAL MODE
    ENTITY StatusTransition
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_transition).

    LOOP AT lt_transition INTO DATA(ls_transition).
      IF ls_transition-FromStatus = ls_transition-ToStatus.
        APPEND VALUE #(
            %tky = ls_transition-%tky ) TO failed-statustransition.

        APPEND VALUE #(
            %tky = ls_transition-%tky
            %msg = new_message_with_text(
                severity = if_abap_behv_message=>severity-error
                text = 'Estátus ORIGEN y DESTINO no pueden ser iguales'
            )
        ) TO reported-statustransition.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD ValidateStatusExistence.

  ENDMETHOD.

ENDCLASS.
