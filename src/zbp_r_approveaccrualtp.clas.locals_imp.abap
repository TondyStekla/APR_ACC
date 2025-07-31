CLASS lhc_ZR_ApproveAccrualTP DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    TYPES:
      tty_keys_for_action   TYPE TABLE FOR ACTION IMPORT ZR_ApproveAccrualTP~ApprovePeriodicAccrual,
      tty_result_for_action TYPE TABLE FOR ACTION RESULT ZR_ApproveAccrualTP~ApprovePeriodicAccrual,
      tty_result            TYPE STANDARD TABLE OF z_a_action_result_boolean.

    TYPES: BEGIN OF lty_key_data,
             AccrualEngineAccrualObjectType TYPE ZR_ApproveAccrualTP-AccrualEngineAccrualObjectType,
             AccrualObjectLogicalSystem     TYPE ZR_ApproveAccrualTP-AccrualObjectLogicalSystem,
             CompanyCode                    TYPE ZR_ApproveAccrualTP-CompanyCode,
             AccrualObject                  TYPE ZR_ApproveAccrualTP-AccrualObject,
             AccrualSubobject               TYPE ZR_ApproveAccrualTP-AccrualSubobject,
             AccrualItemType                TYPE ZR_ApproveAccrualTP-AccrualItemType,
             Ledger                         TYPE ZR_ApproveAccrualTP-Ledger,
             AccrualPeriodEndDate           TYPE ZR_ApproveAccrualTP-AccrualPeriodEndDate,
           END OF lty_key_data.

    TYPES: tty_key_data TYPE TABLE OF lty_key_data.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR PeriodicAccrual RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR PeriodicAccrual RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE PeriodicAccrual.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE PeriodicAccrual.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE PeriodicAccrual.

    METHODS read FOR READ
      IMPORTING keys FOR READ PeriodicAccrual RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK PeriodicAccrual.

    METHODS ApprovePeriodicAccrual FOR MODIFY
      IMPORTING keys FOR ACTION PeriodicAccrual~ApprovePeriodicAccrual RESULT result.

    METHODS RejectPeriodicAccrual FOR MODIFY
      IMPORTING keys FOR ACTION PeriodicAccrual~RejectPeriodicAccrual RESULT result.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR PeriodicAccrual RESULT result.

    METHODS activate FOR MODIFY
      IMPORTING keys FOR ACTION periodicaccrual~activate.

    METHODS ProcessPeriodicAccrual
      IMPORTING
        it_keys TYPE data
        iv_mode TYPE char1
      CHANGING
        result  TYPE tty_result
        failed  TYPE any.

ENDCLASS.

CLASS lhc_ZR_ApproveAccrualTP IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD create.
    " Not supported
  ENDMETHOD.

  METHOD update.
    LOOP AT entities INTO DATA(ls_entity) USING KEY cid WHERE %cid_ref IS INITIAL.
      UPDATE acesobj_item_per
        SET
          " Approval data
          approval_status   = ls_entity-AccrualAmountApprovalStatus
          approved_by       = ls_entity-ApprovedByUser
          approved_on       = ls_entity-AccrualAmountApprovalDate
          approved_at       = ls_entity-AccrualAmountApprovalTime
          " Adjusted data
          adjusted_by       = sy-uname
          adjusted_on       = sy-datlo
          adjusted_at       = sy-timlo
          adjusted_per_amnt_wsl = ls_entity-AccrualAmtInTransCrcy
          " Comment / Reason
          adjstmnt_comment  = ls_entity-ReviewComment
          adjstmnt_reason   = ls_entity-ProposedAccrAmtAdjmtReason
      WHERE comp            = ls_entity-AccrualEngineAccrualObjectType
        AND logsys          = ls_entity-AccrualObjectLogicalSystem
        AND bukrs           = ls_entity-CompanyCode
        AND ref_key         = ls_entity-AccrualObject
        AND ref_subkey      = ls_entity-AccrualSubobject
        AND itemtype        = ls_entity-AccrualItemType
        AND rldnr           = ls_entity-Ledger
      " AND refobj_key = '' ????
        AND period_end_date = ls_entity-AccrualPeriodEndDate.

    ENDLOOP.
  ENDMETHOD.

  METHOD delete.
    " Not supported
  ENDMETHOD.

  METHOD read.
    IF ( keys IS NOT INITIAL ).
      SELECT * FROM ZC_ApproveAccrualTP
        FOR ALL ENTRIES IN @keys
          WHERE AccrualEngineAccrualObjectType = @keys-AccrualEngineAccrualObjectType
            AND AccrualObjectLogicalSystem = @keys-AccrualObjectLogicalSystem
            AND CompanyCode = @keys-CompanyCode
            AND AccrualObject = @keys-AccrualObject
            AND AccrualSubobject = @keys-AccrualSubobject
            AND AccrualItemType = @keys-AccrualItemType
            AND Ledger = @keys-Ledger
            AND AccrualPeriodEndDate = @keys-AccrualPeriodEndDate
            INTO TABLE @DATA(lt_items).
      result = CORRESPONDING #( lt_items ).
    ENDIF.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD ApprovePeriodicAccrual.

    DATA lt_result TYPE STANDARD TABLE OF z_a_action_result_boolean.

    processperiodicaccrual(
      EXPORTING
        it_keys = keys
        iv_mode = 'A'
      CHANGING
        failed  = failed
        result  = lt_result
    ).

    result = VALUE #( FOR ls_result IN lt_result (
      %tky = CORRESPONDING #(
      keys[
      AccrualEngineAccrualObjectType = ls_result-AccrualEngineAccrualObjectType
      AccrualObjectLogicalSystem     = ls_result-AccrualObjectLogicalSystem
      CompanyCode                    = ls_result-CompanyCode
      AccrualObject                  = ls_result-AccrualObject
      AccrualSubobject               = ls_result-AccrualSubobject
      AccrualItemType                = ls_result-AccrualItemType
      Ledger                         = ls_result-Ledger
      AccrualPeriodEndDate           = ls_result-AccrualPeriodEndDate
      ]-%tky
      )
      %param = CORRESPONDING #( ls_result ) ) ).

*    DATA:
*      periodic_accrual_for_update TYPE TABLE FOR UPDATE ZR_ApproveAccrualTP.
*
*    DATA:
*      lo_alv_rvw_apprv_util TYPE REF TO cl_facra_rvw_apprv_accr_util,
*      ls_item_per_key       TYPE facra_item_per_key,
*      ls_item_per_ra_admin  TYPE facra_per_ra_admin,
*      ls_adjusted_amount    TYPE if_ace_mdo_types=>ty_facra_adjusted_amounts,
*      lt_cell_style         TYPE lvc_t_styl,
*      ls_subobj_key         TYPE acesobj_key,
*      ls_item_per_ext       TYPE if_ace_mdo_types=>ty_facra_item_per_ext,
*      lt_item_per_ext       TYPE if_ace_mdo_types=>tt_facra_item_per_ext,
*      lx_ace                TYPE REF TO cx_ace,
*      lb_executed_ok        TYPE abap_bool.
*
*    READ ENTITIES OF ZR_ApproveAccrualTP IN LOCAL MODE
*      ENTITY PeriodicAccrual ALL FIELDS WITH CORRESPONDING #( keys )
*      RESULT DATA(periodicAccruals)
*      FAILED failed.
*
*    LOOP AT periodicAccruals ASSIGNING FIELD-SYMBOL(<periodAccrual>).
*
*      CLEAR:
*        lo_alv_rvw_apprv_util, ls_item_per_key, ls_item_per_ra_admin, lb_executed_ok.
*
*      CREATE OBJECT lo_alv_rvw_apprv_util
*        EXPORTING
*          id_comp            = <periodAccrual>-AccrualEngineAccrualObjectType
*          id_rvw_apprvl_code = 'A'
*          id_keydate         = <periodAccrual>-AccrualPeriodEndDate.
*
*
*      ls_item_per_key = VALUE #(
*        comp              = <periodaccrual>-AccrualEngineAccrualObjectType
*        logsys            = <periodaccrual>-AccrualObjectLogicalSystem
*        bukrs             = <periodaccrual>-CompanyCode
*        ref_key           = <periodaccrual>-AccrualObject
*        ref_subkey        = <periodaccrual>-AccrualSubobject
*        itemtype          = <periodaccrual>-AccrualItemType
*        rldnr             = <periodaccrual>-Ledger
*        ldgrp             = <periodaccrual>-LedgerGroup
*        refobj_key        = '' "??? TYPE=ACE_REFOBJ_ID
*        period_end_date   = <periodaccrual>-AccrualPeriodEndDate
*      ).
*
*      ls_item_per_ra_admin = VALUE #(
*        adjstmnt_comment  = <periodaccrual>-ReviewComment
*        adjstmnt_reason   = <periodaccrual>-ProposedAccrAmtAdjmtReason
*        adjusted_at       = <periodaccrual>-AccrualAmountAdjustmentTime
*        adjusted_by       = <periodaccrual>-AccrualAmountAdjustedByUser
*        adjusted_on       = <periodaccrual>-AccrualAmountAdjustmentDate
*        approval_status   = <periodaccrual>-AccrualAmountApprovalStatus
*        approval_type     = <periodaccrual>-AccrualPostingApprovalType
*        approved_at       = <periodaccrual>-AccrualAmountApprovalTime
*        approved_by       = <periodaccrual>-ApprovedByUser
*        approved_on       = <periodaccrual>-AccrualAmountApprovalDate
*        reviewed_at       = <periodaccrual>-AmountReviewTime
*        reviewed_by       = <periodaccrual>-ReviewedByUser
*        reviewed_on       = <periodaccrual>-AmountReviewDate
*        review_status     = <periodaccrual>-AccrualAmountReviewStatus
*        review_type       = <periodaccrual>-AccrualPostingReviewType
*        xapproved         = COND #( WHEN <periodaccrual>-AccrualAmountApprovalStatus = 'X' THEN 'X' ELSE ' ' )
*        xreviewed         = COND #( WHEN <periodaccrual>-AccrualAmountReviewStatus = 'X' THEN 'X' ELSE ' ' )
*      ).
*
*      "" TODO: Fill ls_adjusted_amount
*
*      TRY.
*          lo_alv_rvw_apprv_util->check_review_approval_allowed(
*            EXPORTING
*              is_item_per_key      = ls_item_per_key
*              is_item_per_ra_admin = ls_item_per_ra_admin
*              is_adjusted_amount   = ls_adjusted_amount
*              id_undo              = ' '
*              it_style             = lt_cell_style
*            IMPORTING
*              es_subobj_key        = ls_subobj_key
*              es_item_per_ext      = ls_item_per_ext ).
*          IF ls_item_per_ext IS NOT INITIAL.
*            INSERT ls_item_per_ext INTO TABLE lt_item_per_ext.
*            lb_executed_ok = lo_alv_rvw_apprv_util->period_data_operation(
*              EXPORTING
*                id_rvw_aprvl_code = 'A'
*                is_subobj_key     = ls_subobj_key
*                id_detdate        = <periodaccrual>-AccrualPeriodEndDate
*                id_savemode       = 'C' "T - Test Mode
*                it_item_per_ext   = lt_item_per_ext
*            ).
*          ENDIF.
*          IF lb_executed_ok = abap_true.
*            APPEND VALUE #( %tky                = <periodAccrual>-%tky
*                    ApprovedByUser              = sy-uname
*                    AccrualAmountApprovalTime   = sy-uzeit
*                    AccrualAmountApprovalDate   = sy-datum
*                    AccrualAmountApprovalStatus = 'X'
*                   ) TO periodic_accrual_for_update.
*          ENDIF.
*        CATCH BEFORE UNWIND cx_ace INTO lx_ace.
*          IF lx_ace->is_resumable = abap_true.
*            IF lx_ace->error_occured( ) = abap_true.
*              "..."
*            ELSE.
*              RESUME.
*            ENDIF.
*          ELSE.
*            "..."
*          ENDIF.
*      ENDTRY.
*
*      " update data
*      MODIFY ENTITIES OF ZR_ApproveAccrualTP IN LOCAL MODE
*             ENTITY PeriodicAccrual
*             UPDATE FIELDS ( ApprovedByUser AccrualAmountApprovalTime AccrualAmountApprovalDate AccrualAmountApprovalStatus )
*             WITH periodic_accrual_for_update.
*      "read changed data for action result
*      READ ENTITIES OF ZR_ApproveAccrualTP IN LOCAL MODE
*             ENTITY PeriodicAccrual
*             ALL FIELDS WITH
*             CORRESPONDING #( periodicAccruals )
*             RESULT DATA(periodicAccrualsUpdated).
*      " action result
**      result = VALUE #( FOR periodicAccrual IN periodicAccrualsUpdated ( %tky   = periodicAccrual-%tky
**                                                                         %param = periodicAccrual ) ).
*
*      result = COND #( WHEN sy-subrc EQ 0 THEN abap_true
*                       ELSE abap_false ).
*
*    ENDLOOP.

  ENDMETHOD.

  METHOD RejectPeriodicAccrual.

    DATA lt_result TYPE STANDARD TABLE OF z_a_action_result_boolean.

    processperiodicaccrual(
      EXPORTING
        it_keys = keys
        iv_mode = 'R'
      CHANGING
        failed  = failed
        result  = lt_result
    ).

    result = VALUE #( FOR ls_result IN lt_result (
      %tky = CORRESPONDING #(
      keys[
      AccrualEngineAccrualObjectType = ls_result-AccrualEngineAccrualObjectType
      AccrualObjectLogicalSystem     = ls_result-AccrualObjectLogicalSystem
      CompanyCode                    = ls_result-CompanyCode
      AccrualObject                  = ls_result-AccrualObject
      AccrualSubobject               = ls_result-AccrualSubobject
      AccrualItemType                = ls_result-AccrualItemType
      Ledger                         = ls_result-Ledger
      AccrualPeriodEndDate           = ls_result-AccrualPeriodEndDate
      ]-%tky
      )
      %param = CORRESPONDING #( ls_result ) ) ).

*    DATA:
*      periodic_accrual_for_update TYPE TABLE FOR UPDATE ZR_ApproveAccrualTP.
*
*    DATA:
*      lo_alv_rvw_apprv_util TYPE REF TO cl_facra_rvw_apprv_accr_util,
*      ls_item_per_key       TYPE facra_item_per_key,
*      ls_item_per_ra_admin  TYPE facra_per_ra_admin,
*      ls_adjusted_amount    TYPE if_ace_mdo_types=>ty_facra_adjusted_amounts,
*      lt_cell_style         TYPE lvc_t_styl,
*      ls_subobj_key         TYPE acesobj_key,
*      ls_item_per_ext       TYPE if_ace_mdo_types=>ty_facra_item_per_ext,
*      lt_item_per_ext       TYPE if_ace_mdo_types=>tt_facra_item_per_ext,
*      lx_ace                TYPE REF TO cx_ace,
*      lb_executed_ok        TYPE abap_bool.
*
*    READ ENTITIES OF ZR_ApproveAccrualTP IN LOCAL MODE
*      ENTITY PeriodicAccrual ALL FIELDS WITH CORRESPONDING #( keys )
*      RESULT DATA(periodicAccruals)
*      FAILED failed.
*
*    LOOP AT periodicAccruals ASSIGNING FIELD-SYMBOL(<periodAccrual>).
*
*      CLEAR:
*        lo_alv_rvw_apprv_util, ls_item_per_key, ls_item_per_ra_admin, lb_executed_ok.
*
*      CREATE OBJECT lo_alv_rvw_apprv_util
*        EXPORTING
*          id_comp            = <periodAccrual>-AccrualEngineAccrualObjectType
*          id_rvw_apprvl_code = 'A'
*          id_keydate         = <periodAccrual>-AccrualPeriodEndDate.
*
*
*      ls_item_per_key = VALUE #(
*        comp              = <periodaccrual>-AccrualEngineAccrualObjectType
*        logsys            = <periodaccrual>-AccrualObjectLogicalSystem
*        bukrs             = <periodaccrual>-CompanyCode
*        ref_key           = <periodaccrual>-AccrualObject
*        ref_subkey        = <periodaccrual>-AccrualSubobject
*        itemtype          = <periodaccrual>-AccrualItemType
*        rldnr             = <periodaccrual>-Ledger
*        ldgrp             = <periodaccrual>-LedgerGroup
*        refobj_key        = '' "??? TYPE=ACE_REFOBJ_ID
*        period_end_date   = <periodaccrual>-AccrualPeriodEndDate
*      ).
*
*      ls_item_per_ra_admin = VALUE #(
*        adjstmnt_comment  = <periodaccrual>-ReviewComment
*        adjstmnt_reason   = <periodaccrual>-ProposedAccrAmtAdjmtReason
*        adjusted_at       = <periodaccrual>-AccrualAmountAdjustmentTime
*        adjusted_by       = <periodaccrual>-AccrualAmountAdjustedByUser
*        adjusted_on       = <periodaccrual>-AccrualAmountAdjustmentDate
*        approval_status   = <periodaccrual>-AccrualAmountApprovalStatus
*        approval_type     = <periodaccrual>-AccrualPostingApprovalType
*        approved_at       = <periodaccrual>-AccrualAmountApprovalTime
*        approved_by       = <periodaccrual>-ApprovedByUser
*        approved_on       = <periodaccrual>-AccrualAmountApprovalDate
*        reviewed_at       = <periodaccrual>-AmountReviewTime
*        reviewed_by       = <periodaccrual>-ReviewedByUser
*        reviewed_on       = <periodaccrual>-AmountReviewDate
*        review_status     = <periodaccrual>-AccrualAmountReviewStatus
*        review_type       = <periodaccrual>-AccrualPostingReviewType
*        xapproved         = COND #( WHEN <periodaccrual>-AccrualAmountApprovalStatus = 'X' THEN 'X' ELSE ' ' )
*        xreviewed         = COND #( WHEN <periodaccrual>-AccrualAmountReviewStatus = 'X' THEN 'X' ELSE ' ' )
*      ).
*
*      "" TODO: Fill ls_adjusted_amount
*
*      TRY.
*          lo_alv_rvw_apprv_util->check_review_approval_allowed(
*            EXPORTING
*              is_item_per_key      = ls_item_per_key
*              is_item_per_ra_admin = ls_item_per_ra_admin
*              is_adjusted_amount   = ls_adjusted_amount
*              id_undo              = ' '
*              it_style             = lt_cell_style
*            IMPORTING
*              es_subobj_key        = ls_subobj_key
*              es_item_per_ext      = ls_item_per_ext ).
*          IF ls_item_per_ext IS NOT INITIAL.
*            INSERT ls_item_per_ext INTO TABLE lt_item_per_ext.
*            lb_executed_ok = lo_alv_rvw_apprv_util->period_data_operation(
*              EXPORTING
*                id_rvw_aprvl_code = 'A'
*                is_subobj_key     = ls_subobj_key
*                id_detdate        = <periodaccrual>-AccrualPeriodEndDate
*                id_savemode       = 'C' "T - Test Mode
*                it_item_per_ext   = lt_item_per_ext
*            ).
*          ENDIF.
*          IF lb_executed_ok = abap_true.
*            APPEND VALUE #( %tky                = <periodAccrual>-%tky
*                    ApprovedByUser              = sy-uname
*                    AccrualAmountApprovalTime   = sy-uzeit
*                    AccrualAmountApprovalDate   = sy-datum
*                    AccrualAmountApprovalStatus = 'X'
*                   ) TO periodic_accrual_for_update.
*          ENDIF.
*        CATCH BEFORE UNWIND cx_ace INTO lx_ace.
*          IF lx_ace->is_resumable = abap_true.
*            IF lx_ace->error_occured( ) = abap_true.
*              "..."
*            ELSE.
*              RESUME.
*            ENDIF.
*          ELSE.
*            "..."
*          ENDIF.
*      ENDTRY.
*
*      " update data
*      MODIFY ENTITIES OF ZR_ApproveAccrualTP IN LOCAL MODE
*             ENTITY PeriodicAccrual
*             UPDATE FIELDS ( ApprovedByUser AccrualAmountApprovalTime AccrualAmountApprovalDate AccrualAmountApprovalStatus )
*             WITH periodic_accrual_for_update.
*      "read changed data for action result
*      READ ENTITIES OF ZR_ApproveAccrualTP IN LOCAL MODE
*             ENTITY PeriodicAccrual
*             ALL FIELDS WITH
*             CORRESPONDING #( periodicAccruals )
*             RESULT DATA(periodicAccrualsUpdated).
*      " action result
*      result = VALUE #( FOR periodicAccrual IN periodicAccrualsUpdated ( %tky   = periodicAccrual-%tky
*                                                                         %param = periodicAccrual ) ).
*
*    ENDLOOP.

  ENDMETHOD.

  METHOD get_instance_features.

    " Enable/Disable Approve or Reject based on approval status"

    READ ENTITIES OF ZR_ApproveAccrualTP IN LOCAL MODE
      ENTITY PeriodicAccrual FIELDS ( AccrualAmountApprovalStatus ) WITH CORRESPONDING #( keys )
      RESULT DATA(periodicAccruals)
      FAILED failed.
    result = VALUE #( FOR periodicAccrual IN periodicAccruals
                       ( %tky                             = periodicAccrual-%tky
                         %action-ApprovePeriodicAccrual   = COND #( WHEN periodicAccrual-AccrualAmountApprovalStatus = 'X' "Approved -> disable Approve button
                                                            THEN if_abap_behv=>fc-o-disabled ELSE if_abap_behv=>fc-o-enabled )
                         %action-RejectPeriodicAccrual    = COND #( WHEN periodicAccrual-AccrualAmountApprovalStatus = 'R' "Rejected -> disable Reject button
                                                            THEN if_abap_behv=>fc-o-disabled ELSE if_abap_behv=>fc-o-enabled )
                       ) ).
  ENDMETHOD.

  METHOD Activate.
  ENDMETHOD.

  METHOD ProcessPeriodicAccrual.

    DATA:
        periodic_accrual_for_update TYPE TABLE FOR UPDATE ZR_ApproveAccrualTP.

    DATA:
      lo_alv_rvw_apprv_util TYPE REF TO cl_facra_rvw_apprv_accr_util,
      ls_item_per_key       TYPE facra_item_per_key,
      ls_item_per_ra_admin  TYPE facra_per_ra_admin,
      ls_adjusted_amount    TYPE if_ace_mdo_types=>ty_facra_adjusted_amounts,
      lt_cell_style         TYPE lvc_t_styl,
      ls_subobj_key         TYPE acesobj_key,
      ls_item_per_ext       TYPE if_ace_mdo_types=>ty_facra_item_per_ext,
      lt_item_per_ext       TYPE if_ace_mdo_types=>tt_facra_item_per_ext,
      lx_ace                TYPE REF TO cx_ace,
      lb_executed_ok        TYPE abap_bool.

    READ ENTITIES OF ZR_ApproveAccrualTP IN LOCAL MODE
      ENTITY PeriodicAccrual ALL FIELDS WITH CORRESPONDING #( it_keys )
      RESULT DATA(periodicAccruals)
      FAILED failed.

    DATA(lv_undo) = COND #( WHEN iv_mode EQ 'A' THEN abap_false
                            WHEN iv_mode EQ 'R' THEN abap_true ).

    LOOP AT periodicAccruals ASSIGNING FIELD-SYMBOL(<periodAccrual>).

      CLEAR:
        lo_alv_rvw_apprv_util, ls_item_per_key, ls_item_per_ra_admin, lb_executed_ok.

      CREATE OBJECT lo_alv_rvw_apprv_util
        EXPORTING
          id_comp            = <periodAccrual>-AccrualEngineAccrualObjectType
          id_rvw_apprvl_code = 'A'
          id_keydate         = <periodAccrual>-AccrualPeriodEndDate.

      ls_item_per_key = VALUE #(
        comp              = <periodaccrual>-AccrualEngineAccrualObjectType
        logsys            = <periodaccrual>-AccrualObjectLogicalSystem
        bukrs             = <periodaccrual>-CompanyCode
        ref_key           = <periodaccrual>-AccrualObject
        ref_subkey        = <periodaccrual>-AccrualSubobject
        itemtype          = <periodaccrual>-AccrualItemType
        rldnr             = <periodaccrual>-Ledger
        ldgrp             = <periodaccrual>-LedgerGroup
        refobj_key        = '' "??? TYPE=ACE_REFOBJ_ID
        period_end_date   = <periodaccrual>-AccrualPeriodEndDate
      ).

      ls_item_per_ra_admin = VALUE #(
        adjstmnt_comment  = <periodaccrual>-ReviewComment
        adjstmnt_reason   = <periodaccrual>-ProposedAccrAmtAdjmtReason
        adjusted_at       = <periodaccrual>-AccrualAmountAdjustmentTime
        adjusted_by       = <periodaccrual>-AccrualAmountAdjustedByUser
        adjusted_on       = <periodaccrual>-AccrualAmountAdjustmentDate
        approval_status   = <periodaccrual>-AccrualAmountApprovalStatus
        approval_type     = <periodaccrual>-AccrualPostingApprovalType
        approved_at       = <periodaccrual>-AccrualAmountApprovalTime
        approved_by       = <periodaccrual>-ApprovedByUser
        approved_on       = <periodaccrual>-AccrualAmountApprovalDate
        reviewed_at       = <periodaccrual>-AmountReviewTime
        reviewed_by       = <periodaccrual>-ReviewedByUser
        reviewed_on       = <periodaccrual>-AmountReviewDate
        review_status     = <periodaccrual>-AccrualAmountReviewStatus
        review_type       = <periodaccrual>-AccrualPostingReviewType
        xapproved         = COND #( WHEN <periodaccrual>-AccrualAmountApprovalStatus = 'X' THEN 'X' ELSE ' ' )
        xreviewed         = COND #( WHEN <periodaccrual>-AccrualAmountReviewStatus = 'X' THEN 'X' ELSE ' ' )
      ).

      "" TODO: Fill ls_adjusted_amount

      TRY.
          lo_alv_rvw_apprv_util->check_review_approval_allowed(
            EXPORTING
              is_item_per_key      = ls_item_per_key
              is_item_per_ra_admin = ls_item_per_ra_admin
              is_adjusted_amount   = ls_adjusted_amount
              id_undo              = lv_undo
              it_style             = lt_cell_style
            IMPORTING
              es_subobj_key        = ls_subobj_key
              es_item_per_ext      = ls_item_per_ext ).
          IF ls_item_per_ext IS NOT INITIAL.
            INSERT ls_item_per_ext INTO TABLE lt_item_per_ext.
            lb_executed_ok = lo_alv_rvw_apprv_util->period_data_operation(
              EXPORTING
                id_rvw_aprvl_code = 'A'
                is_subobj_key     = ls_subobj_key
                id_detdate        = <periodaccrual>-AccrualPeriodEndDate
                id_savemode       = 'C' "T - Test Mode
                it_item_per_ext   = lt_item_per_ext
            ).
          ENDIF.
          IF lb_executed_ok = abap_true.
            APPEND VALUE #( %tky                = <periodAccrual>-%tky
                    ApprovedByUser              = sy-uname
                    AccrualAmountApprovalTime   = sy-uzeit
                    AccrualAmountApprovalDate   = sy-datum
                    AccrualAmountApprovalStatus = 'X'
                   ) TO periodic_accrual_for_update.
          ENDIF.
        CATCH BEFORE UNWIND cx_ace INTO lx_ace.
          IF lx_ace->is_resumable = abap_true.
            IF lx_ace->error_occured( ) = abap_true.
              "..."
            ELSE.
              RESUME.
            ENDIF.
          ELSE.
            "..."
          ENDIF.
      ENDTRY.

      " update data
      MODIFY ENTITIES OF ZR_ApproveAccrualTP IN LOCAL MODE
             ENTITY PeriodicAccrual
             UPDATE FIELDS ( ApprovedByUser AccrualAmountApprovalTime AccrualAmountApprovalDate AccrualAmountApprovalStatus )
             WITH periodic_accrual_for_update.

      "read changed data for action result
      READ ENTITIES OF ZR_ApproveAccrualTP IN LOCAL MODE
             ENTITY PeriodicAccrual
             ALL FIELDS WITH
             CORRESPONDING #( periodicAccruals )
             RESULT DATA(periodicAccrualsUpdated).

      " action result
*      result = VALUE #( FOR periodicAccrual IN periodicAccrualsUpdated ( %tky   = periodicAccrual-%tky
*                                                                         %param = periodicAccrual ) ).

      result = VALUE #( FOR periodicAccrual IN periodicAccrualsUpdated (  AccrualEngineAccrualObjectType   = periodicAccrual-AccrualEngineAccrualObjectType
                                                                          AccrualObjectLogicalSystem = periodicAccrual-AccrualObjectLogicalSystem
                                                                          CompanyCode = periodicAccrual-CompanyCode
                                                                          AccrualObject = periodicAccrual-AccrualObject
                                                                          AccrualSubobject = periodicAccrual-AccrualSubobject
                                                                          AccrualItemType = periodicAccrual-AccrualItemType
                                                                          Ledger = periodicAccrual-Ledger
                                                                          AccrualPeriodEndDate = periodicAccrual-AccrualPeriodEndDate
                                                                          Success = COND #( WHEN sy-subrc EQ 0 THEN abap_true ELSE abap_false ) ) ).


      " Nerefreshujeme zaznamy, result moze vratit TRUE/FALSE zmenim hodnotu v UI hodnotu (status atd.) - Vyhoda je ze nestrati focus na riadky oznacenie a podobne
      " kdezto pri refresh sa nacitava vsetko odznova a teda strati sa focus aj oznacenie a pripadne aj nacitane zaznamy ak je ich viac ako defualt pocet.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZR_APPROVEACCRUALTP DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZR_APPROVEACCRUALTP IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
