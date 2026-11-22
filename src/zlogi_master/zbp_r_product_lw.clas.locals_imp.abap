CLASS lhc_Product DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR Product RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR Product RESULT result.

    METHODS SetProductActive FOR DETERMINE ON MODIFY
       keys FOR Product~SetProductActive.

    METHODS SetProductCodeUppercase FOR DETERMINE ON MODIFY
       keys FOR Product~SetProductCodeUppercase.

    METHODS ValidateProductCode FOR VALIDATE ON SAVE
       keys FOR Product~ValidateProductCode.

ENDCLASS.

CLASS lhc_Product IMPLEMENTATION.

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

  METHOD SetProductActive.
   READ ENTITIES OF zr_product_lw IN LOCAL MODE
      ENTITY Product
      FIELDS ( IsActive )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_products).

    DATA lt_update TYPE TABLE FOR UPDATE zr_product_lw.

    LOOP AT lt_products INTO DATA(ls_product).

      IF ls_product-IsActive IS INITIAL.

        APPEND VALUE #(
          %tky     = ls_product-%tky
          IsActive = abap_true
        ) TO lt_update.

      ENDIF.

    ENDLOOP.

    IF lt_update IS NOT INITIAL.

      MODIFY ENTITIES OF zr_product_lw IN LOCAL MODE
        ENTITY Product
        UPDATE FIELDS ( IsActive )
        WITH lt_update.

    ENDIF.
  ENDMETHOD.

  METHOD SetProductCodeUppercase.
   READ ENTITIES OF zr_product_lw IN LOCAL MODE
      ENTITY Product
      FIELDS ( ProductCode )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_products).

    DATA lt_update TYPE TABLE FOR UPDATE zr_product_lw.

    LOOP AT lt_products INTO DATA(ls_product).

      DATA(lv_product_code) = ls_product-ProductCode.

      TRANSLATE lv_product_code TO UPPER CASE.

      IF lv_product_code <> ls_product-ProductCode.

        APPEND VALUE #(
          %tky       = ls_product-%tky
          ProductCode = lv_product_code
        ) TO lt_update.

      ENDIF.

    ENDLOOP.

    IF lt_update IS NOT INITIAL.

      MODIFY ENTITIES OF zr_product_lw IN LOCAL MODE
        ENTITY Product
        UPDATE FIELDS ( ProductCode )
        WITH lt_update.

    ENDIF.
  ENDMETHOD.

  METHOD ValidateProductCode.
  READ ENTITIES OF zr_product_lw IN LOCAL MODE
      ENTITY Product
      FIELDS ( ProductUUID ProductCode )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_products).

    LOOP AT lt_products INTO DATA(ls_product).

      SELECT SINGLE FROM zlogi_product
        FIELDS product_uuid
        WHERE product_code = @ls_product-ProductCode
          AND product_uuid <> @ls_product-ProductUUID
        INTO @DATA(lv_existing_uuid).

      IF sy-subrc = 0.

        APPEND VALUE #(
          %tky = ls_product-%tky
        ) TO failed-product.

        APPEND VALUE #(
          %tky = ls_product-%tky
          %msg = new_message(
            id       = 'ZLOGI_MSG'
            number   = '008'
            severity = if_abap_behv_message=>severity-error
            v1       = ls_product-ProductCode
          )
          %element-ProductCode = if_abap_behv=>mk-on
        ) TO reported-product.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
