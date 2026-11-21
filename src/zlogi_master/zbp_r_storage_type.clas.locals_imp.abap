CLASS lhc_StoreType DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR StoreType RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR StoreType RESULT result.

    METHODS SetStorageTypeActive FOR DETERMINE ON MODIFY
       keys FOR StoreType~SetStorageTypeActive.

    METHODS SetStorageTypeCodeUppercase FOR DETERMINE ON MODIFY
       keys FOR StoreType~SetStorageTypeCodeUppercase.

    METHODS ValidateStorageTypeCode FOR VALIDATE ON SAVE
       keys FOR StoreType~ValidateStorageTypeCode.

ENDCLASS.

CLASS lhc_StoreType IMPLEMENTATION.

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

  METHOD SetStorageTypeActive.
  READ ENTITIES OF zr_storage_type IN LOCAL MODE
    ENTITY StoreType
    FIELDS ( IsActive )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_storage_types).

  DATA lt_update TYPE TABLE FOR UPDATE zr_storage_type.

  LOOP AT lt_storage_types INTO DATA(ls_storage_type).

    IF ls_storage_type-IsActive IS INITIAL.

      APPEND VALUE #(
        %tky     = ls_storage_type-%tky
        IsActive = abap_true
      ) TO lt_update.

    ENDIF.

  ENDLOOP.

  IF lt_update IS NOT INITIAL.

    MODIFY ENTITIES OF zr_storage_type IN LOCAL MODE
      ENTITY StoreType
      UPDATE FIELDS ( IsActive )
      WITH lt_update.

  ENDIF.
  ENDMETHOD.

  METHOD SetStorageTypeCodeUppercase.
   READ ENTITIES OF zr_storage_type IN LOCAL MODE
    ENTITY StoreType
    FIELDS ( StorageTypeCode )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_storage_types).

  DATA lt_update TYPE TABLE FOR UPDATE zr_storage_type.

  LOOP AT lt_storage_types INTO DATA(ls_storage_type).

    IF ls_storage_type-StorageTypeCode <>
       to_upper( ls_storage_type-StorageTypeCode ).

      APPEND VALUE #(
        %tky           = ls_storage_type-%tky
        StorageTypeCode = to_upper( ls_storage_type-StorageTypeCode )
      ) TO lt_update.

    ENDIF.

  ENDLOOP.

  IF lt_update IS NOT INITIAL.

    MODIFY ENTITIES OF zr_storage_type IN LOCAL MODE
      ENTITY StoreType
      UPDATE FIELDS ( StorageTypeCode )
      WITH lt_update.

  ENDIF.

  ENDMETHOD.

  METHOD ValidateStorageTypeCode.
   READ ENTITIES OF zr_storage_type IN LOCAL MODE
    ENTITY StoreType
    FIELDS ( StorageTypeUUID StorageTypeCode )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_storage_types).

  IF lt_storage_types IS INITIAL.
    RETURN.
  ENDIF.

  SELECT storage_type_uuid,
         storage_type_code
    FROM zlogi_stor_type
    FOR ALL ENTRIES IN @lt_storage_types
    WHERE storage_type_code = @lt_storage_types-StorageTypeCode
    INTO TABLE @DATA(lt_existing).

  LOOP AT lt_storage_types INTO DATA(ls_storage_type).

    DATA(lv_duplicate) = abap_false.

    LOOP AT lt_existing INTO DATA(ls_existing)
      WHERE storage_type_code = ls_storage_type-StorageTypeCode
        AND storage_type_uuid <> ls_storage_type-StorageTypeUUID.

      lv_duplicate = abap_true.
      EXIT.

    ENDLOOP.

    IF lv_duplicate = abap_true.

      APPEND VALUE #(
        %tky = ls_storage_type-%tky
      ) TO failed-storetype.

      APPEND VALUE #(
        %tky = ls_storage_type-%tky
        %msg = new_message(
          id       = 'ZLOGI_MSG'
          number   = '007'
          v1       = ls_storage_type-StorageTypeCode
          severity = if_abap_behv_message=>severity-error
        )
        %element-StorageTypeCode = if_abap_behv=>mk-on
      ) TO reported-storetype.

    ENDIF.

  ENDLOOP.

  ENDMETHOD.

ENDCLASS.
