*&---------------------------------------------------------------------*
*& Report ZDEV_R_EXCLUDE_BUTTONS
*&---------------------------------------------------------------------*
*&
*& This demo program demonstrates how to exclude buttons from alv
*&
*&---------------------------------------------------------------------*
REPORT ZDEV_R_EXCLUDE_BUTTONS.

INCLUDE zdev_r_exclude_buttons_data.
INCLUDE zdev_r_exclude_buttons_cls.
INCLUDE zdev_r_exclude_buttons_pbo.
INCLUDE zdev_r_exclude_buttons_pai.

*----------------------------------------------------------------------*
*                           START-OF-SELECTION                         *
*----------------------------------------------------------------------*
START-OF-SELECTION.

  go_data = NEW #( ).
  go_data->get_data( ).

  IF gt_data[] IS NOT INITIAL.
    CALL SCREEN 100.
  ELSE.
    MESSAGE 'No records found' TYPE 'S'.
  ENDIF.
