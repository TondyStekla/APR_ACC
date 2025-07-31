@AbapCatalog.sqlViewName: 'ZTSTACCDSV1'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'TST - New CDS'
@VDM.viewType: #COMPOSITE

define view ZTST_ACE_CDS_V1 // R_ApproveAccrual
  //with parameters
  //  P_KeyDate : ace_period_end_date
  as select from I_AccrEngineAccrSubobjAccrItem

  association [0..1] to I_AccrEngineBasicPerdcAmounts  as _AccrEngineBasicPerdcAmount   on  $projection.AccrualEngineAccrualObjectType = _AccrEngineBasicPerdcAmount.AccrualEngineAccrualObjectType
                                                                                        and $projection.AccrualObjectLogicalSystem     = _AccrEngineBasicPerdcAmount.AccrualObjectLogicalSystem
                                                                                        and $projection.CompanyCode                    = _AccrEngineBasicPerdcAmount.CompanyCode
                                                                                        and $projection.AccrualObject                  = _AccrEngineBasicPerdcAmount.AccrualObject
                                                                                        and $projection.AccrualSubobject               = _AccrEngineBasicPerdcAmount.AccrualSubobject
                                                                                        and $projection.AccrualItemType                = _AccrEngineBasicPerdcAmount.AccrualItemType
                                                                                        and $projection.Ledger                         = _AccrEngineBasicPerdcAmount.Ledger

  association [0..1] to I_AccrEngineItemTypeCrcySttg   as _AccrEngineItemTypeCrcySttg   on  $projection.AccrualEngineAccrualObjectType = _AccrEngineItemTypeCrcySttg.AccrualEngineAccrualObjectType
                                                                                        and $projection.AccrualItemType                = _AccrEngineItemTypeCrcySttg.AccrualItemType
                                                                                        and $projection.CompanyCode                    = _AccrEngineItemTypeCrcySttg.CompanyCode
                                                                                        and $projection.Ledger                         = _AccrEngineItemTypeCrcySttg.Ledger
                                                                                        and _AccrEngineItemTypeCrcySttg.CurrencyRole   = '00'

  association [0..1] to I_AccrItemTypeForLedgerGroup   as _AccrItemTypeForLedgerGroup   on  $projection.AccrualEngineAccrualObjectType = _AccrItemTypeForLedgerGroup.AccrualEngineApplication
                                                                                        and $projection.CompanyCode                    = _AccrItemTypeForLedgerGroup.CompanyCode
                                                                                        and $projection.AccrualItemType                = _AccrItemTypeForLedgerGroup.AccrualItemType
                                                                                        and $projection.Ledger                         = _AccrItemTypeForLedgerGroup.Ledger

  association [0..1] to I_AccrSubObjItemPostedAmt      as _AccrSubObjItemPostedAmt      on  $projection.AccrualEngineAccrualObjectType = _AccrSubObjItemPostedAmt.AccrualEngineApplication
                                                                                        and $projection.AccrualObjectLogicalSystem     = _AccrSubObjItemPostedAmt.AccrualObjectLogicalSystem
                                                                                        and $projection.CompanyCode                    = _AccrSubObjItemPostedAmt.CompanyCode
                                                                                        and $projection.AccrualObject                  = _AccrSubObjItemPostedAmt.AccrualObject
                                                                                        and $projection.AccrualSubobject               = _AccrSubObjItemPostedAmt.AccrualSubobject
                                                                                        and $projection.AccrualItemType                = _AccrSubObjItemPostedAmt.AccrualItemType
                                                                                        and $projection.Ledger                         = _AccrSubObjItemPostedAmt.Ledger
                                                                                        and $projection.accrualperiodenddate           = _AccrSubObjItemPostedAmt.AccrualPeriodEndDate

  association [0..1] to I_AccrualObjectAcctAssgmt      as _AccrualObjectAcctAssgmt      on  $projection.AccrualEngineAccrualObjectType =  _AccrualObjectAcctAssgmt.AccrualEngineApplication
                                                                                        and $projection.AccrualObjectLogicalSystem     =  _AccrualObjectAcctAssgmt.AccrualObjectLogicalSystem
                                                                                        and $projection.CompanyCode                    =  _AccrualObjectAcctAssgmt.CompanyCode
                                                                                        and $projection.AccrualObject                  =  _AccrualObjectAcctAssgmt.AccrualObject
                                                                                        and $projection.AccrualSubobject               =  _AccrualObjectAcctAssgmt.AccrualSubobject
                                                                                        and $projection.accrualperiodenddate           >= _AccrualObjectAcctAssgmt.AccrAcctAssgmtValdtyStrtDte
                                                                                        and $projection.accrualperiodenddate           <= _AccrualObjectAcctAssgmt.AccrAcctAssgmtValdtyEndDte

  association [0..1] to I_CompanyCode                  as _CompanyCode                  on  $projection.CompanyCode = _CompanyCode.CompanyCode

  association [0..1] to I_PeriodAccrual                as _PeriodAccrual                on  $projection.AccrualEngineAccrualObjectType = _PeriodAccrual.AccrualEngineApplication
                                                                                        and $projection.AccrualObjectLogicalSystem     = _PeriodAccrual.AccrualObjectLogicalSystem
                                                                                        and $projection.CompanyCode                    = _PeriodAccrual.CompanyCode
                                                                                        and $projection.AccrualObject                  = _PeriodAccrual.AccrualObject
                                                                                        and $projection.AccrualSubobject               = _PeriodAccrual.AccrualSubobject
                                                                                        and $projection.AccrualItemType                = _PeriodAccrual.AccrualItemType
                                                                                        and $projection.Ledger                         = _PeriodAccrual.Ledger
                                                                                        and $projection.accrualperiodenddate           = _PeriodAccrual.AccrualPeriodEndDate

  association [0..*] to I_PurOrdAccrualObject          as _PurOrdAccrualObject          on  $projection.AccrualEngineAccrualObjectType =  _PurOrdAccrualObject.AccrualEngineApplication
                                                                                        and $projection.AccrualObjectLogicalSystem     =  _PurOrdAccrualObject.AccrualObjectLogicalSystem
                                                                                        and $projection.CompanyCode                    =  _PurOrdAccrualObject.CompanyCode
                                                                                        and $projection.AccrualObject                  =  _PurOrdAccrualObject.AccrualObject
                                                                                        and $projection.AccrualSubobject               =  _PurOrdAccrualObject.AccrualSubobject
                                                                                        and $projection.AccrualItemType                =  _PurOrdAccrualObject.AccrualItemType
                                                                                        and $projection.Ledger                         =  _PurOrdAccrualObject.Ledger
                                                                                        and $projection.accrualperiodenddate           >= _PurOrdAccrualObject.AccrSubobjectItmValdtyStrtDte
                                                                                        and $projection.accrualperiodenddate           <= _PurOrdAccrualObject.AccrSubobjectItmValdtyEndDte

{
  key AccrualEngineAccrualObjectType,
  key AccrualObjectLogicalSystem,
  key CompanyCode,
  key AccrualObject,
  key AccrualSubobject,
  key AccrualItemType,
  key Ledger,
  key _AccrEngineBasicPerdcAmount.AccrualPeriodEndDate,

      TransactionCurrency,
      CompanyCodeCurrency,
      GlobalCurrency,

      @Semantics.amount.currencyCode: 'TransactionCurrency'
      TotalAccrAmountInTransCrcy,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
      TotalAccrAmtInCompanyCodeCrcy,
      @Semantics.amount.currencyCode: 'GlobalCurrency'
      TotalAccrAmountInGlobalCrcy,

      AccrualMethod,
      _AccrSubobj.AccrSubobjectLifeCycleStatus,

      // Associations

      _AccrCompanyCode,
      _AccrObj,
      _AccrSubobj,
      _Ledger,
      _AccrEngineBasicPerdcAmount,
      _AccrualObjectAcctAssgmt,
      _AccrEngineItemTypeCrcySttg,
      _PeriodAccrual,
      _AccrSubObjItemPostedAmt,
      //_PurchaseOrderAccrual,
      _PurOrdAccrualObject,
      _AccrItemTypeForLedgerGroup,
      _CompanyCode

}

where
  /*       _AccrEngineBasicPerdcAmount.AccrualPeriodEndDate = $parameters.P_KeyDate
    and  AccrSubobjectItmValdtyEndDte                      >= $parameters.P_KeyDate
    and  AccrSubobjectItmValdtyStrtDte                     <= $parameters.P_KeyDate
    and*/
  (
       AccrualEngineAccrualObjectType = 'POAC'
    or AccrualEngineAccrualObjectType = 'ACAC'
  )
