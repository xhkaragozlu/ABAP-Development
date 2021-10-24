*&---------------------------------------------------------------------*
*& Report ZDEV_R_TEXT_EDITOR
*&---------------------------------------------------------------------*
*&  This demo program demonstrates how to create and use a TextEdit
*&  control
*&---------------------------------------------------------------------*
REPORT zdev_r_text_editor.

CONSTANTS: c_line_length TYPE i VALUE 256.

*  define table type for data exchange
TYPES: BEGIN OF ty_text_table,
         line(c_line_length) TYPE c,
       END OF ty_text_table.

DATA:
*  reference to custom container: necessary to bind TextEdit Control
  go_editor_container TYPE REF TO cl_gui_custom_container,
*  reference to wrapper class of control based on OO Framework
  go_text_editor      TYPE REF TO cl_gui_textedit,
*  table to exchange text
  gt_text_table       TYPE TABLE OF ty_text_table,
*  other variables
  gv_ok_code          LIKE sy-ucomm.   " returns code from screen


*  necessary to flush the automation queue
CLASS cl_gui_cfw DEFINITION LOAD.

START-OF-SELECTION.
  CALL SCREEN 100.

*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.

  IF go_text_editor IS INITIAL.

*  set status
    SET PF-STATUS 'STATUS100'.
*  set titlebar
    SET TITLEBAR  'TTLBAR100'.

*  create control container
    CREATE OBJECT go_editor_container
      EXPORTING
        container_name              = 'TEXTEDITOR'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5.
    IF sy-subrc NE 0.
    ENDIF.

*  create calls constructor, which initializes, creates and links
*  a TextEdit Control
    CREATE OBJECT go_text_editor
      EXPORTING
        parent                     = go_editor_container
        wordwrap_mode              =
*             cl_gui_textedit=>wordwrap_off
                                     cl_gui_textedit=>wordwrap_at_fixed_position
*             cl_gui_textedit=>WORDWRAP_AT_WINDOWBORDER
        wordwrap_position          = c_line_length
        wordwrap_to_linebreak_mode = cl_gui_textedit=>true.

*  hide toolbar
    CALL METHOD go_text_editor->set_toolbar_mode
      EXPORTING
        toolbar_mode = cl_gui_textedit=>false.

*  hide statusbar
    CALL METHOD go_text_editor->set_statusbar_mode
      EXPORTING
        statusbar_mode = cl_gui_textedit=>false.

  ENDIF.

*  remember: there is an automatic flush at the end of PBO!

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE gv_ok_code.

    WHEN '&F03' OR '&F15' OR '&F12'.

      PERFORM exit_program.

    WHEN '&GET'.

*  retrieve table from control
      CALL METHOD go_text_editor->get_text_as_r3table
        IMPORTING
          table = gt_text_table.
      IF sy-subrc NE 0.
      ENDIF.

      CALL METHOD cl_gui_cfw=>flush
        EXCEPTIONS
          OTHERS = 1.
      IF sy-subrc NE 0.
      ENDIF.

    WHEN '&SET'.

*  send table to control
      CALL METHOD go_text_editor->set_text_as_r3table
        EXPORTING
          table = gt_text_table.

*  no flush here:
*  the automatic flush at the end of PBO does the job

  ENDCASE.

  CLEAR gv_ok_code.

ENDMODULE.


*&---------------------------------------------------------------------*
*&      Form  EXIT_PROGRAM
*&---------------------------------------------------------------------*
FORM exit_program .

*  destroy control.
  IF NOT go_text_editor IS INITIAL.

    CALL METHOD go_text_editor->free
      EXCEPTIONS
        OTHERS = 1.
    IF sy-subrc NE 0.
    ENDIF.

*  free ABAP object also
    FREE go_text_editor.

  ENDIF.


*  destroy container
  IF NOT go_editor_container IS INITIAL.

    CALL METHOD go_editor_container->free
      EXCEPTIONS
        OTHERS = 1.
    IF sy-subrc NE 0.
    ENDIF.

*  free ABAP object also
    FREE go_editor_container.

  ENDIF.


*  finally flush
  CALL METHOD cl_gui_cfw=>flush
    EXCEPTIONS
      OTHERS = 1.
  IF sy-subrc NE 0.
  ENDIF.

  LEAVE PROGRAM.

ENDFORM.
