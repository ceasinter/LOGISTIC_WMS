CLASS lhc_UnitsMeasure DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR UnitsMeasure RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR UnitsMeasure RESULT result.

    METHODS SetUnitActive FOR DETERMINE ON MODIFY
       keys FOR UnitsMeasure~SetUnitActive.

ENDCLASS.

CLASS lhc_UnitsMeasure IMPLEMENTATION.

  METHOD get_instance_authorizations.
  LOOP AT keys INTO DATA(ls_key).

      APPEND VALUE #(
        %tky = ls_key-%tky
        %update = if_abap_behv=>auth-allowed
        %delete = if_abap_behv=>auth-allowed
      ) TO result.

    ENDLOOP.
  ENDMETHOD.

  METHOD get_global_authorizations.
  IF requested_authorizations-%create = if_abap_behv=>mk-on.
      result-%create = if_abap_behv=>auth-allowed.
    ENDIF.
  ENDMETHOD.

  METHOD SetUnitActive.
  READ ENTITIES OF zr_units_meas IN LOCAL MODE
      ENTITY UnitsMeasure
      FIELDS ( IsActive )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_units).

    DATA lt_update TYPE TABLE FOR UPDATE zr_units_meas.

    LOOP AT lt_units INTO DATA(ls_unit).

      IF ls_unit-IsActive IS INITIAL.

        APPEND VALUE #(
          %tky     = ls_unit-%tky
          IsActive = abap_true
        ) TO lt_update.

      ENDIF.

    ENDLOOP.

    IF lt_update IS NOT INITIAL.

      MODIFY ENTITIES OF zr_units_meas IN LOCAL MODE
        ENTITY UnitsMeasure
        UPDATE FIELDS ( IsActive )
        WITH lt_update.

    ENDIF.
  ENDMETHOD.

ENDCLASS.
