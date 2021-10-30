*&---------------------------------------------------------------------*
*& Include          ZDEV_R_EXCLUDE_BUTTONS_DATA
*&---------------------------------------------------------------------*

*----------------------------------------------------------------------*
*                             T Y P E S                                *
*----------------------------------------------------------------------*
TYPES: BEGIN OF ty_data,
         carrid   TYPE sflight-carrid,
         connid   TYPE sflight-connid,
         fldate   TYPE sflight-fldate,
         price    TYPE sflight-price,
         currency TYPE sflight-currency,
       END OF ty_data.
*----------------------------------------------------------------------*
*                  C L A S S  &  O B J E C T S                          *
*----------------------------------------------------------------------*
CLASS lcl_class DEFINITION DEFERRED.
DATA  go_data   TYPE REF TO lcl_class.

*----------------------------------------------------------------------*
*               I N T E R N A L   T A B L E S                          *
*----------------------------------------------------------------------*
DATA: gt_data    TYPE TABLE OF ty_data,
      gt_exclude TYPE ui_functions.

*----------------------------------------------------------------------*
*                     S T R U C T U R E S                              *
*----------------------------------------------------------------------*
DATA: gs_data    LIKE LINE OF gt_data,
      gs_exclude TYPE ui_func.

*----------------------------------------------------------------------*
*                        V A R I A B L E S                             *
*----------------------------------------------------------------------*
DATA: gv_ok_code LIKE sy-ucomm.

*----------------------------------------------------------------------*
*               A L V    P A R A M E T E R S                           *
*----------------------------------------------------------------------*
DATA : go_container_name   TYPE scrfname VALUE 'CONTAINER',
       go_custom_container TYPE REF TO cl_gui_custom_container,
       go_container        TYPE REF TO cl_gui_container,
       go_alv_grid         TYPE REF TO cl_gui_alv_grid,
       gs_layout           TYPE lvc_s_layo,
       gt_fcat             TYPE lvc_t_fcat,
       gs_fcat             TYPE lvc_s_fcat.
