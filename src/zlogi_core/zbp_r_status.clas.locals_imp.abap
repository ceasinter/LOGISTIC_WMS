CLASS lhc_Status DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR Status RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR Status RESULT result.

ENDCLASS.

CLASS lhc_Status IMPLEMENTATION.

  METHOD get_instance_authorizations.
    LOOP AT keys INTO DATA(key).

      APPEND VALUE #(
        %tky = key-%tky
        %update = if_abap_behv=>auth-allowed
      ) TO result.

    ENDLOOP.
  ENDMETHOD.

  METHOD get_global_authorizations.
    IF requested_authorizations-%create = if_abap_behv=>mk-on.
      result-%create = if_abap_behv=>auth-allowed.
    ENDIF.

    IF requested_authorizations-%update = if_abap_behv=>mk-on.
      result-%update = if_abap_behv=>auth-allowed.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
