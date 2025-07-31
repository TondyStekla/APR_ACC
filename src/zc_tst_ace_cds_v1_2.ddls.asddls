@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Payment Run Plan'
@VDM.viewType: #CONSUMPTION
@VDM.usage.type:[ #TRANSACTIONAL_PROCESSING_SERVICE ] 
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.dataClass: #MIXED
@Search.searchable: true
define root view entity ZC_TST_ACE_CDS_V1_2
provider contract transactional_query
  //with parameters
  //  P_KeyDate : ace_period_end_date
  as projection on ZTST_ACE_CDS_V1_2 // ( P_KeyDate: $parameters.P_KeyDate )
{
  key AccrualEngineAccrualObjectType,
  key AccrualObjectLogicalSystem,
  key CompanyCode,
  key AccrualObject,
  key AccrualSubobject,
  key AccrualItemType,
  key Ledger,
  key AccrualPeriodEndDate,
      GLAccount,
      AccountAssignmentNumber,
      Material,
      ProductType,
      Supplier,
      PurchasingDocumentItemText,
      PurchaseOrder,
      PurchaseOrderItem,
      LedgerGroup,
      AccrualMethod,
      AccrSubobjectLifeCycleStatus,
      AccrSubobjPauseDate,
      AccrSubobjSuspensionDate,
      AccrSubobjPrematureFinishDate,
      AccrSubobjHdrStartOfLifeDate,
      AccrSubobjHdrEndOfLifeDate,
      CostCenter,
      ProfitCenter,
      SalesOrder,
      SalesOrderItem,
      //WBSElement,
      DeferralItemType,
      TransactionCurrency,
      CompanyCodeCurrency,
      GlobalCurrency,
      AccrualAmountApprovalStatus,
      AccrualPostingApprovalType,
      ApprovedByUser,
      AccrualAmountReviewStatus,
      AccrualPostingReviewType,
      ReviewedByUser,
      ProposedAccrAmtAdjmtReason,
      ReviewComment,
      AccrualAmountProposedByUser,
      AccrualAmountAdjustedByUser,
      TotalAccrAmountInTransCrcy,
      TotalAccrAmtInCompanyCodeCrcy,
      TotalAccrAmountInGlobalCrcy,
      PostedPeriodAmtInTransCrcy,
      PostedPeriodAmtInCoCodeCrcy,
      PostedPeriodAmtInGlobalCrcy,
      AccrualAmtInTransCrcy,
      AccrualAmtInGlobalCrcy,
      AccrualAmtInCCCrcy,
      PostedCurPeriodAmtInTransCrcy,
      PostedCurPeriodAmtInCoCodeCrcy,
      PostedCurPeriodAmtInGlobalCrcy,
      ProposedAccrAmtInTransCrcy,
      ProposedAccrAmtInCoCodeCrcy,
      ProposedAccrAmtInGlobalCrcy,
      ActualCostInTransCrcy,
      ActualCostAmtInCCCrcy,
      ActualCostInGlobalCrcy,
      DeferredCostInTransCrcy,
      DeferredCostInCoCodeCrcy,
      DeferredCostInGlobalCrcy,
      PlannedCostInTransCrcy,
      PlndCostInCoCodeCrcy,
      PlannedCostInGlobalCrcy,
      RecognizedCostInTransCrcy,
      RecognizedCostInCoCodeCrcy,
      RecognizedCostInGlobalCrcy,
      AdjustedCostInTransCrcy,
      AdjustedCostInCoCodeCrcy,
      AdjustedCostInGlobalCrcy

}
