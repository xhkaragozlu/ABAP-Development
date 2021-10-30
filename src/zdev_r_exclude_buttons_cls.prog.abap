*&---------------------------------------------------------------------*
*& Include          ZDEV_R_EXCLUDE_BUTTONS_CLS
*&---------------------------------------------------------------------*

*----------------------------------------------------------------------*
*       CLASS lcl_class DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_class DEFINITION.

  PUBLIC SECTION.
    METHODS:
      get_data,
      exclude_buttons,
      create_container,
      set_field_catalog,
      set_layout,
      show_alv.

ENDCLASS.

*----------------------------------------------------------------------*
*       CLASS lcl_class IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
CLASS lcl_class IMPLEMENTATION.

  METHOD get_data.

    SELECT carrid
           connid
           fldate
           price
           currency
      FROM sflight
      INTO TABLE gt_data
      UP TO 20 ROWS.

  ENDMETHOD.

  METHOD exclude_buttons.

*    exclude alv info button
    gs_exclude = cl_gui_alv_grid=>mc_fc_info.
    APPEND gs_exclude TO gt_exclude.

*    exclude alv fc_view button
    gs_exclude = cl_gui_alv_grid=>mc_fc_views.
    APPEND gs_exclude TO gt_exclude.

*    exclude alv subtotal button
    gs_exclude = cl_gui_alv_grid=>mc_fc_subtot.
    APPEND gs_exclude TO gt_exclude.

*    exclude alv graph button
    gs_exclude = cl_gui_alv_grid=>mc_fc_graph.
    APPEND gs_exclude TO gt_exclude.


  ENDMETHOD.

  METHOD create_container.

    CREATE OBJECT go_custom_container
      EXPORTING
        container_name = go_container_name.

    CREATE OBJECT go_alv_grid
      EXPORTING
        i_parent = go_custom_container.

  ENDMETHOD.

  METHOD set_field_catalog.

    REFRESH gt_fcat.

    gs_fcat-fieldname = 'CARRID'.
    gs_fcat-tabname = 'GT_DATA'.
    gs_fcat-outputlen = '10'.
    gs_fcat-reptext = 'CARRID'.

    APPEND gs_fcat TO gt_fcat.

    gs_fcat-fieldname = 'CONNID'.
    gs_fcat-tabname = 'GT_DATA'.
    gs_fcat-outputlen = '10'.
    gs_fcat-reptext = 'CONNID'.
    APPEND gs_fcat TO gt_fcat.

    gs_fcat-fieldname = 'FLDATE'.
    gs_fcat-tabname = 'GT_DATA'.
    gs_fcat-outputlen = '10'.
    gs_fcat-reptext = 'FLDATE'.
    APPEND gs_fcat TO gt_fcat.

    gs_fcat-fieldname = 'PRICE'.
    gs_fcat-tabname = 'GT_DATA'.
    gs_fcat-outputlen = '10'.
    gs_fcat-reptext = 'PRICE'.
    APPEND gs_fcat TO gt_fcat.

    gs_fcat-fieldname = 'CURRENCY'.
    gs_fcat-tabname = 'GT_DATA'.
    gs_fcat-outputlen = '10'.
    gs_fcat-reptext = 'CURRENCY'.
    APPEND gs_fcat TO gt_fcat.

    LOOP AT gt_fcat ASSIGNING FIELD-SYMBOL(<line>).
      CASE <line>-fieldname.
        WHEN 'STATUS'.
*          <line>-scrtext_m = 'Onay'.
*          <line>-scrtext_s = 'Onay'.
*          <line>-scrtext_l = 'Onay'.
      ENDCASE.

    ENDLOOP.

  ENDMETHOD.


  METHOD set_layout.

    CLEAR gs_layout.
    gs_layout-zebra = 'X'.
    gs_layout-cwidth_opt = 'X'.
    gs_layout-sel_mode = 'A'.

  ENDMETHOD.

  METHOD show_alv.

    CALL METHOD go_alv_grid->set_table_for_first_display
      EXPORTING
        i_save               = 'A'
        is_layout            = gs_layout
        it_toolbar_excluding = gt_exclude
      CHANGING
        it_outtab            = gt_data[]
        it_fieldcatalog      = gt_fcat.

  ENDMETHOD.

ENDCLASS.
