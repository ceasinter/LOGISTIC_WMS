CLASS lhc_StockType DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR StockType RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR StockType RESULT result.

    METHODS SetStockTypeActive FOR DETERMINE ON MODIFY
       keys FOR StockType~SetStockTypeActive.
    METHODS SetStockTypeCodeUppercase FOR DETERMINE ON MODIFY
      keys FOR StockType~SetStockTypeCodeUppercase.

ENDCLASS.

CLASS lhc_StockType IMPLEMENTATION.

  METHOD get_instance_authorizations.
    LOOP AT keys INTO DATA(key).

      APPEND VALUE #(
        %tky    = key-%tky
        %update = if_abap_behv=>auth-allowed
        %delete = if_abap_behv=>auth-allowed
      ) TO result.

    ENDLOOP.
  ENDMETHOD.

  METHOD get_global_authorizations.
    IF requested_authorizations-%create
      = if_abap_behv=>mk-on.

      result-%create = if_abap_behv=>auth-allowed.

    ENDIF.
  ENDMETHOD.

  METHOD SetStockTypeActive.
    READ ENTITIES OF zr_stock_type IN LOCAL MODE
        ENTITY StockType
        FIELDS ( IsActive )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_stock_types).

    DATA lt_update TYPE TABLE FOR UPDATE zr_stock_type.

    LOOP AT lt_stock_types INTO DATA(ls_stock_type).

      IF ls_stock_type-IsActive IS INITIAL.

        APPEND VALUE #(
          %tky     = ls_stock_type-%tky
          IsActive = abap_true
        ) TO lt_update.

      ENDIF.

    ENDLOOP.

    IF lt_update IS NOT INITIAL.

      MODIFY ENTITIES OF zr_stock_type IN LOCAL MODE
        ENTITY StockType
        UPDATE FIELDS ( IsActive )
        WITH lt_update.

    ENDIF.
  ENDMETHOD.

  METHOD SetStockTypeCodeUppercase.
READ ENTITIES OF zr_stock_type IN LOCAL MODE
      ENTITY StockType
      FIELDS ( StockTypeCode )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_stock_type).

    DATA lt_update TYPE TABLE FOR UPDATE zr_stock_type.

    LOOP AT lt_stock_type INTO DATA(ls_stock_type).

      DATA(lv_stock_type_code) = ls_stock_type-StockTypeCode.

      TRANSLATE lv_stock_type_code TO UPPER CASE.

      IF lv_stock_type_code <> ls_stock_type-StockTypeCode.

        APPEND VALUE #(
          %tky       = ls_stock_type-%tky
          StockTypeCode = lv_stock_type_code
        ) TO lt_update.

      ENDIF.

    ENDLOOP.

    IF lt_update IS NOT INITIAL.

      MODIFY ENTITIES OF zr_stock_type IN LOCAL MODE
        ENTITY StockType
        UPDATE FIELDS ( StockTypeCode )
        WITH lt_update.

    ENDIF.
  ENDMETHOD.

ENDCLASS.
