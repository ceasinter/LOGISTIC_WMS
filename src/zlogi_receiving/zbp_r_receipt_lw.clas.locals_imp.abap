CLASS lhc_Receipt DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR Receipt RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR Receipt RESULT result.
    METHODS SetReceiptDefaults FOR DETERMINE ON MODIFY
      keys FOR Receipt~SetReceiptDefaults.

ENDCLASS.

CLASS lhc_Receipt IMPLEMENTATION.

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
  IF requested_authorizations-%create = if_abap_behv=>mk-on.

    result-%create = if_abap_behv=>auth-allowed.

  ENDIF.
  ENDMETHOD.

  METHOD SetReceiptDefaults.
  READ ENTITIES OF zr_receipt_lw IN LOCAL MODE
    ENTITY Receipt
    FIELDS ( ReceiptDate StatusCode )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_receipts).

  DATA lt_update TYPE TABLE FOR UPDATE zr_receipt_lw.

  LOOP AT lt_receipts INTO DATA(ls_receipt).

    APPEND VALUE #(
      %tky = ls_receipt-%tky

      ReceiptDate = COND #(
        WHEN ls_receipt-ReceiptDate IS INITIAL
        THEN cl_abap_context_info=>get_system_date( )
        ELSE ls_receipt-ReceiptDate
      )

      StatusCode = COND #(
        WHEN ls_receipt-StatusCode IS INITIAL
        THEN '01'
        ELSE ls_receipt-StatusCode
      )

    ) TO lt_update.

  ENDLOOP.

  IF lt_update IS NOT INITIAL.

    MODIFY ENTITIES OF zr_receipt_lw IN LOCAL MODE
      ENTITY Receipt
      UPDATE FIELDS ( ReceiptDate StatusCode )
      WITH lt_update.

  ENDIF.

  ENDMETHOD.

ENDCLASS.



