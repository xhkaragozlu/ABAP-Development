*&---------------------------------------------------------------------*
*& Report ZDEV_R_SALV
*&---------------------------------------------------------------------*
*& This demo program demonstrates how to use SALV.
*&---------------------------------------------------------------------*
REPORT zdev_r_salv.

*&---------------------------------------------------------------------*
*&               C L A S S   D E F I N I T I O N
*&---------------------------------------------------------------------*
CLASS lcl_class DEFINITION.

  PUBLIC SECTION.
    METHODS: get_data,
             show_alv.

ENDCLASS.

*&---------------------------------------------------------------------*
*&               D A T A   D E F I N I T I O N S
*&---------------------------------------------------------------------*
TYPES: BEGIN OF ty_flight,
         carrid   TYPE sflight-carrid,
         connid   TYPE sflight-connid,
         fldate   TYPE sflight-fldate,
         price    TYPE sflight-price,
         currency TYPE sflight-currency,
       END OF ty_flight.

DATA gt_flight TYPE TABLE OF ty_flight.

DATA: go_salv TYPE REF TO cl_salv_table,
      go_smsg TYPE REF TO cx_salv_msg.

*&---------------------------------------------------------------------*
*&                S T A R T   O F   S E L E C T I O N
*&---------------------------------------------------------------------*
START-OF-SELECTION.

  DATA go_data TYPE REF TO lcl_class.
  go_data = NEW #( ).
  go_data->get_data( ).

  IF gt_flight IS NOT INITIAL.
    go_data->show_alv( ).
  ELSE.
    MESSAGE 'No records found.' TYPE 'S'.
  ENDIF.

*&---------------------------------------------------------------------*
*&               C L A S S   I M P L E M E N T A T I O N
*&---------------------------------------------------------------------*
CLASS lcl_class IMPLEMENTATION.
*
  METHOD get_data.

    SELECT carrid,
           connid,
           fldate,
           price,
           currency
      FROM sflight
      INTO TABLE @gt_flight
     UP TO 20 ROWS.

  ENDMETHOD.

  METHOD show_alv.

    TRY.
        cl_salv_table=>factory(
          IMPORTING
            r_salv_table = go_salv
          CHANGING
            t_table      = gt_flight ).

      CATCH cx_salv_msg INTO go_smsg.
    ENDTRY.

    go_salv->display( ).

  ENDMETHOD.

ENDCLASS.
