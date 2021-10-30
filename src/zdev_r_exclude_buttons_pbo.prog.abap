*&---------------------------------------------------------------------*
*& Include          ZDEV_R_EXCLUDE_BUTTONS_PBO
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.

  SET PF-STATUS 'STATUS100'.
  SET TITLEBAR  'TTLBAR100'.

  IF go_custom_container IS INITIAL.

    go_data->create_container( ).
    go_data->set_field_catalog( ).
    go_data->set_layout( ).
    go_data->exclude_buttons( ).
    go_data->show_alv( ).

  ELSE.

    CALL METHOD go_alv_grid->refresh_table_display.

  ENDIF.

ENDMODULE.
