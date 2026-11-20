CLASS lhc_StatusTransition DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR StatusTransition RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR StatusTransition RESULT result.

    METHODS ValidateStatusExistence FOR VALIDATE ON SAVE
       keys FOR StatusTransition~ValidateStatusExistence.

    METHODS ValidateTransition FOR VALIDATE ON SAVE
       keys FOR StatusTransition~ValidateTransition.


ENDCLASS.

CLASS lhc_StatusTransition IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.


  METHOD ValidateStatusExistence.
    READ ENTITIES OF zr_status
      ENTITY Status
      FIELDS ( IsActive IsInitial IsFinal )
      WITH VALUE #(
        FOR key IN keys
        (
          %key-ProcessCode = key-ProcessCode
          %key-StatusCode  = key-FromStatus
        )
      )
      RESULT DATA(lt_from_status).

    READ ENTITIES OF zr_status
      ENTITY Status
      FIELDS ( IsActive IsInitial IsFinal )
      WITH VALUE #(
        FOR key IN keys
        (
          %key-ProcessCode = key-ProcessCode
          %key-StatusCode  = key-ToStatus
        )
      )
      RESULT DATA(lt_to_status).

    LOOP AT keys INTO DATA(ls_key).

      " Validar estado de origen
      READ TABLE lt_from_status
        WITH TABLE KEY entity COMPONENTS
                 ProcessCode = ls_key-ProcessCode
                 StatusCode  = ls_key-FromStatus
        INTO DATA(ls_from_status).

      IF sy-subrc <> 0 OR ls_from_status-IsActive <> abap_true.
        APPEND VALUE #(
          %tky = ls_key-%tky
        ) TO failed-StatusTransition.

        APPEND VALUE #(
          %tky = ls_key-%tky
          %msg = new_message(
            id       = 'ZLOGI_MSG'
            number   = '002'
            severity = if_abap_behv_message=>severity-error
            v1       = ls_key-FromStatus
            v2       = ls_key-ProcessCode
          )
        ) TO reported-StatusTransition.

      ELSEIF ls_from_status-IsFinal = abap_true.

        APPEND VALUE #( %tky = ls_key-%tky )
          TO failed-StatusTransition.

        APPEND VALUE #(
          %tky = ls_key-%tky
          %msg = new_message(
            id       = 'ZLOGI_MSG'
            number   = '004'
            severity = if_abap_behv_message=>severity-error
            v1       = ls_key-FromStatus
          )
        ) TO reported-StatusTransition.
      ENDIF.

      " Validar estado de destino
      READ TABLE lt_to_status
  WITH TABLE KEY entity COMPONENTS
    ProcessCode = ls_key-ProcessCode
    StatusCode  = ls_key-ToStatus
  INTO DATA(ls_to_status).

      IF sy-subrc <> 0 OR ls_to_status-IsActive <> abap_true.

        APPEND VALUE #( %tky = ls_key-%tky )
          TO failed-StatusTransition.

        APPEND VALUE #(
          %tky = ls_key-%tky
          %msg = new_message(
            id       = 'ZLOGI_MSG'
            number   = '003'
            severity = if_abap_behv_message=>severity-error
            v1       = ls_key-ToStatus
            v2       = ls_key-ProcessCode
          )
        ) TO reported-StatusTransition.

      ELSEIF ls_to_status-IsInitial = abap_true.

        APPEND VALUE #( %tky = ls_key-%tky )
          TO failed-StatusTransition.

        APPEND VALUE #(
          %tky = ls_key-%tky
          %msg = new_message(
            id       = 'ZLOGI_MSG'
            number   = '005'
            severity = if_abap_behv_message=>severity-error
            v1       = ls_key-ToStatus
          )
        ) TO reported-StatusTransition.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD ValidateTransition.
    LOOP AT keys INTO DATA(key).
      IF key-FromStatus = key-ToStatus.

        APPEND VALUE #(
          %tky = key-%tky
        ) TO failed-statustransition.

        APPEND VALUE #(
          %tky = key-%tky
          %msg = new_message(
              id = 'ZLOGI_MSG'
              number = '001'
              severity = if_abap_behv_message=>severity-error
              v1 = key-FromStatus
          )

        ) TO reported-statustransition.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
