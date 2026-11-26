CLASS zcl_create_rec_interval DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_create_rec_interval IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    TRY.

        cl_numberrange_runtime=>number_get(
          EXPORTING
            nr_range_nr = '01'
            object      = 'ZLOGIREC'
          IMPORTING
            number      = DATA(lv_number)
            returncode  = DATA(lv_returncode)
        ).

        out->write( |Número generado: { lv_number }| ).
        out->write( |Código de retorno: { lv_returncode }| ).

      CATCH cx_number_ranges INTO DATA(lx_error).

        out->write( lx_error->get_text( ) ).

    ENDTRY.

  ENDMETHOD.
ENDCLASS.
