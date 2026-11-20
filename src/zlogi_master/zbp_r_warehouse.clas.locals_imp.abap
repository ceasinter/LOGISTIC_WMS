CLASS lhc_Warehouse DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR Warehouse RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR Warehouse RESULT result.

    METHODS ValidateWarehouseCode FOR VALIDATE ON SAVE
       keys FOR Warehouse~ValidateWarehouseCode.
    METHODS SetWarehouseCodeUppercase FOR DETERMINE ON MODIFY
       keys FOR Warehouse~SetWarehouseCodeUppercase.
    METHODS SetWarehouseActive FOR DETERMINE ON MODIFY
      keys FOR Warehouse~SetWarehouseActive.

ENDCLASS.

CLASS lhc_Warehouse IMPLEMENTATION.

  METHOD get_instance_authorizations.
    LOOP AT keys INTO DATA(ls_key).

      APPEND VALUE #(
        %tky    = ls_key-%tky
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

  METHOD ValidateWarehouseCode.
    " Obtener los almacenes que se están procesando
    READ ENTITIES OF zr_warehouse IN LOCAL MODE
      ENTITY Warehouse
      FIELDS ( WarehouseUUID WarehouseCode )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_warehouses).

    IF lt_warehouses IS INITIAL.
      RETURN.
    ENDIF.

    " Buscar códigos que ya existen en la tabla persistente
    SELECT warehouse_uuid,
           warehouse_code
      FROM zlogi_warehouse
      FOR ALL ENTRIES IN @lt_warehouses
      WHERE warehouse_code = @lt_warehouses-WarehouseCode
      INTO TABLE @DATA(lt_existing).

    " Comprobar duplicados
    LOOP AT lt_warehouses INTO DATA(ls_warehouse).

      DATA(lv_duplicate) = abap_false.

      LOOP AT lt_existing INTO DATA(ls_existing)
        WHERE warehouse_code = ls_warehouse-WarehouseCode
          AND warehouse_uuid <> ls_warehouse-WarehouseUUID.

        lv_duplicate = abap_true.
        EXIT.

      ENDLOOP.

      IF lv_duplicate = abap_true.

        APPEND VALUE #(
          %tky = ls_warehouse-%tky
        ) TO failed-Warehouse.

        APPEND VALUE #(
          %tky = ls_warehouse-%tky
          %msg = new_message(
            id       = 'ZLOGI_MSG'
            number   = '006'
            v1       = ls_warehouse-WarehouseCode
            severity = if_abap_behv_message=>severity-error
          )
          %element-WarehouseCode = if_abap_behv=>mk-on
        ) TO reported-Warehouse.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD SetWarehouseCodeUppercase.
    READ ENTITIES OF zr_warehouse IN LOCAL MODE
      ENTITY Warehouse
      FIELDS ( WarehouseCode )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_warehouses).

    DATA lt_update TYPE TABLE FOR UPDATE zr_warehouse.

    LOOP AT lt_warehouses INTO DATA(ls_warehouse).

      IF ls_warehouse-WarehouseCode <>
         to_upper( ls_warehouse-WarehouseCode ).

        APPEND VALUE #(
          %tky         = ls_warehouse-%tky
          WarehouseCode = to_upper( ls_warehouse-WarehouseCode )
        ) TO lt_update.

      ENDIF.

    ENDLOOP.

    IF lt_update IS NOT INITIAL.

      MODIFY ENTITIES OF zr_warehouse IN LOCAL MODE
        ENTITY Warehouse
        UPDATE FIELDS ( WarehouseCode )
        WITH lt_update.

    ENDIF.
  ENDMETHOD.

  METHOD SetWarehouseActive.
  READ ENTITIES OF zr_warehouse IN LOCAL MODE
    ENTITY Warehouse
    FIELDS ( IsActive )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_warehouses).

  DATA lt_update TYPE TABLE FOR UPDATE zr_warehouse.

  LOOP AT lt_warehouses INTO DATA(ls_warehouse).

    IF ls_warehouse-IsActive IS INITIAL.

      APPEND VALUE #(
        %tky    = ls_warehouse-%tky
        IsActive = abap_true
      ) TO lt_update.

    ENDIF.

  ENDLOOP.

  IF lt_update IS NOT INITIAL.

    MODIFY ENTITIES OF zr_warehouse IN LOCAL MODE
      ENTITY Warehouse
      UPDATE FIELDS ( IsActive )
      WITH lt_update.

  ENDIF.
  ENDMETHOD.

ENDCLASS.
