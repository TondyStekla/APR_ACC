@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: 'Approve Accrual'
}
@ObjectModel: {
  usageType.dataClass: #MIXED,
  usageType.serviceQuality: #X,
  usageType.sizeCategory: #L
}
@AccessControl.authorizationCheck: #NOT_REQUIRED // TODO: Change later
@Search.searchable: true
define root view entity ZC_ApproveAccrualTP
  provider contract transactional_query
  as projection on ZR_ApproveAccrualTP
{
          @EndUserText: {
            label: 'Component',
            quickInfo: 'Accrual Engine Application Component'
          }
          @ObjectModel: {
            upperCase: true
          }
  key     AccrualEngineAccrualObjectType,
          @EndUserText: {
            label: 'Logical System',
            quickInfo: 'Logical System of Accrual Object'
          }
          @ObjectModel: {
            upperCase: true
          }
  key     AccrualObjectLogicalSystem,
          @EndUserText: {
            label: 'Company Code',
            quickInfo: 'Company Code'
          }
          @ObjectModel: {
            upperCase: true
          }
          @ObjectModel.text.element: [ 'CompanyCodeName' ]
          @UI.textArrangement: #TEXT_LAST
  key     CompanyCode,
          @EndUserText: {
            label: 'Accrual Object',
            quickInfo: 'Identifier of the Accrual Object'
          }
          @ObjectModel: {
            upperCase: true
          }
          @Search.defaultSearchElement: true
          @Search.fuzzinessThreshold: 0.7
  key     AccrualObject,
          @EndUserText: {
            label: 'Accrual Subobject',
            quickInfo: 'Identifier of the Accrual Subobject'
          }
          @ObjectModel: {
            upperCase: true
          }
  key     AccrualSubobject,
          @EndUserText: {
            label: 'Accrual Item Type',
            quickInfo: 'Accrual Item Type'
          }
          @ObjectModel: {
            upperCase: true
          }
  key     AccrualItemType,
          @EndUserText: {
            label: 'Ledger',
            quickInfo: 'Ledger in General Ledger Accounting'
          }
          @ObjectModel: {
            upperCase: true
          }
  key     Ledger,
          @EndUserText: {
            label: 'Last Day of Period',
            quickInfo: 'Last Day of Period in Accrual Engine'
          }
          @Semantics.calendar.dayOfYear: true
  key     AccrualPeriodEndDate,

          @EndUserText: {
          label: 'Is Ready'
          }
          @ObjectModel: {
            upperCase: true
          }
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_APRVACCR_EXIT_STATUS'
          @ObjectModel.text.element: [ 'AccrualIsReadyText' ]
          @UI.textArrangement: #TEXT_ONLY  
  virtual AccrualIsReady        : char1,

          @UI.hidden: true
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_APRVACCR_EXIT_STATUS'
  virtual AccrualIsReadyCritlty : numc1,

          @UI.hidden: true
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_APRVACCR_EXIT_STATUS'
  virtual AccrualIsReadyText    : char60,

          @EndUserText: {
            label: 'G/L Account',
            quickInfo: 'G/L Account Number'
          }
          @ObjectModel: {
            upperCase: true
          }
          GLAccount,
          @EndUserText: {
            label: 'Account Assgmt No.',
            quickInfo: 'Sequential Number of Account Assignment'
          }
          AccountAssignmentNumber,
          @EndUserText: {
            label: 'Article',
            quickInfo: 'Article Number'
          }
          @ObjectModel: {
            upperCase: true
          }
          Material,
          @EndUserText: {
            label: 'Product Type Group',
            quickInfo: 'Product Type Group'
          }
          @ObjectModel: {
            upperCase: true
          }
          ProductType,
          @EndUserText: {
            label: 'Supplier',
            quickInfo: 'Supplier'
          }
          @ObjectModel: {
            upperCase: true
          }
          Supplier,
          @EndUserText: {
            label: 'Short Text',
            quickInfo: 'Short Text'
          }
          PurchasingDocumentItemText,
          @EndUserText: {
            label: 'Purchase Order',
            quickInfo: 'Purchase Order Number'
          }
          @ObjectModel: {
            upperCase: true
          }
          PurchaseOrder,
          @EndUserText: {
            label: 'Purchase Order Item',
            quickInfo: 'Item Number of Purchase Order'
          }
          PurchaseOrderItem,
          @EndUserText: {
            label: 'Ledger Group',
            quickInfo: 'Ledger Group'
          }
          @ObjectModel: {
            upperCase: true
          }
          LedgerGroup,
          @EndUserText: {
            label: 'Accr/Defrl Method',
            quickInfo: 'Accrual/Deferral Method'
          }
          @ObjectModel: {
            upperCase: true
          }
          AccrualMethod,
          @EndUserText: {
            label: 'Obsolete',
            quickInfo: 'Accrual Item is Obsolete'
          }
          @ObjectModel: {
            upperCase: true
          }
          AccrualItemIsObsolete,
          @EndUserText: {
            label: 'Lifecycle Status',
            quickInfo: 'Lifecycle Status of an Accrual Subobject'
          }
          @ObjectModel.text.element: [ 'AccrSubobjLifeCycleStatusName' ]
          @UI.textArrangement: #TEXT_LAST
          AccrSubobjectLifeCycleStatus,
          @EndUserText: {
            label: 'Pause Date',
            quickInfo: 'Pause Date'
          }
          AccrSubobjPauseDate,
          @EndUserText: {
            label: 'Suspension Date',
            quickInfo: 'Suspension Date'
          }
          AccrSubobjSuspensionDate,
          @EndUserText: {
            label: 'Premtre Finish Date',
            quickInfo: 'Premature Finish Date'
          }
          AccrSubobjPrematureFinishDate,
          @EndUserText: {
            label: 'Start of Life',
            quickInfo: 'Start of Life of an Accrual Subobject or Item'
          }
          AccrSubobjHdrStartOfLifeDate,
          @EndUserText: {
            label: 'End of Life',
            quickInfo: 'End of Life of an Accrual Subobject or Item'
          }
          AccrSubobjHdrEndOfLifeDate,
          @EndUserText: {
            label: 'Cost Center',
            quickInfo: 'Cost Center'
          }
          @ObjectModel: {
            upperCase: true
          }
          CostCenter,
          @EndUserText: {
            label: 'Profit Center',
            quickInfo: 'Profit Center'
          }
          @ObjectModel: {
            upperCase: true
          }
          ProfitCenter,
          SalesOrder,
          SalesOrderItem,
          @EndUserText: {
            label: 'Deferral Item Type',
            quickInfo: 'Accrual Item Type for Deferred Costs'
          }
          @ObjectModel: {
            upperCase: true
          }
          DeferralItemType,
          @UI.hidden: true
          ProposedAccrAmtIsExisting,
          @EndUserText: {
            label: 'Period Amnt Source'
          }
          @ObjectModel: {
            upperCase: true
          }
          AccrPeriodAmtCalculationMethod,
          @EndUserText: {
            label: 'Transaction Currency',
            quickInfo: 'Transaction Currency'
          }
          @ObjectModel: {
            upperCase: true
          }
          TransactionCurrency,
          @EndUserText: {
            label: 'Company Code Currency',
            quickInfo: 'Company Code Currency'
          }
          @ObjectModel: {
            upperCase: true
          }
          CompanyCodeCurrency,
          @EndUserText: {
            label: 'Global Currency',
            quickInfo: 'Global Currency'
          }
          @ObjectModel: {
            upperCase: true
          }
          GlobalCurrency,
          @EndUserText: {
            label: 'Approval Status',
            quickInfo: 'Approval Status'
          }
          @ObjectModel: {
            upperCase: true
          }
          @ObjectModel.text.element: [ 'ApprovalStatusText' ]
          @UI.textArrangement: #TEXT_LAST
          AccrualAmountApprovalStatus,
          @EndUserText: {
            label: 'Approval Type',
            quickInfo: 'Approval Type'
          }
          @ObjectModel: {
            upperCase: true
          }
          AccrualPostingApprovalType,
          @EndUserText: {
            label: 'Approved By',
            quickInfo: 'Name of the user who has approved the accrual amount'
          }
          @ObjectModel: {
            upperCase: true
          }
          ApprovedByUser,
          AccrualAmountApprovalDate,
          AccrualAmountApprovalTime,
          @EndUserText: {
            label: 'Review Status',
            quickInfo: 'Review Status'
          }
          @ObjectModel: {
            upperCase: true
          }
          @ObjectModel.text.element: [ 'ReviewStatusText' ]
          @UI.textArrangement: #TEXT_LAST
          AccrualAmountReviewStatus,
          @EndUserText: {
            label: 'Review Type',
            quickInfo: 'Review Type'
          }
          @ObjectModel: {
            upperCase: true
          }
          AccrualPostingReviewType,
          @EndUserText: {
            label: 'Reviewed By',
            quickInfo: 'Name of the user who has reviewed the period amount'
          }
          @ObjectModel: {
            upperCase: true
          }
          ReviewedByUser,
          AmountReviewDate,
          AmountReviewTime,
          @EndUserText: {
            label: 'Adjustment Reason',
            quickInfo: 'Reason Code'
          }
          @ObjectModel: {
            upperCase: true
          }
          ProposedAccrAmtAdjmtReason,
          @EndUserText: {
            label: 'Comment',
            quickInfo: 'Comment'
          }
          ReviewComment,
          @EndUserText: {
            label: 'Proposed By',
            quickInfo: 'Name of the user who has proposed the accrual amount'
          }
          @ObjectModel: {
            upperCase: true
          }
          AccrualAmountProposedByUser,
          AccrualAmountProposalDate,
          AccrualAmountProposalTime,
          @EndUserText: {
            label: 'Adjusted By',
            quickInfo: 'Name of the user who has adjusted the period amount'
          }
          @ObjectModel: {
            upperCase: true
          }
          AccrualAmountAdjustedByUser,
          AccrualAmountAdjustmentDate,
          AccrualAmountAdjustmentTime,
          @EndUserText: {
            label: 'Total A/D Amt (TC)',
            quickInfo: 'Total Accrual/Deferral Amount in Transaction Currency'
          }
          @Semantics: {
            amount.currencyCode: 'TransactionCurrency'
          }
          TotalAccrAmountInTransCrcy,
          @EndUserText: {
            label: 'Total A/D Amt (CC)',
            quickInfo: 'Total Accrual/Deferral Amount in Company Code Currency'
          }
          @Semantics: {
            amount.currencyCode: 'CompanyCodeCurrency'
          }
          TotalAccrAmtInCompanyCodeCrcy,
          @EndUserText: {
            label: 'Total A/D Amt (GC)',
            quickInfo: 'Total Accrual/Deferral Amount in Global Currency'
          }
          @Semantics: {
            amount.currencyCode: 'GlobalCurrency'
          }
          TotalAccrAmountInGlobalCrcy,
          @EndUserText: {
            label: 'Accmltd Pstd Amt(TC)',
            quickInfo: 'Accumulated Posted Accrual Amount in Transaction Currency'
          }
          @Semantics: {
            amount.currencyCode: 'TransactionCurrency'
          }
          PostedPeriodAmtInTransCrcy,
          @EndUserText: {
            label: 'Accmltd Pstd Amt(CC)',
            quickInfo: 'Accumulated Posted Accrual Amount in Company Code Currency'
          }
          @Semantics: {
            amount.currencyCode: 'CompanyCodeCurrency'
          }
          PostedPeriodAmtInCoCodeCrcy,
          @EndUserText: {
            label: 'Accmltd Pstd Amt(GC)',
            quickInfo: 'Accumulated Posted Accrual Amount in Global Currency'
          }
          @Semantics: {
            amount.currencyCode: 'GlobalCurrency'
          }
          PostedPeriodAmtInGlobalCrcy,
          @EndUserText: {
            label: 'Accrual Amt (TC)',
            quickInfo: 'Accrual Amount in Transaction Currency'
          }
          @Semantics: {
            amount.currencyCode: 'TransactionCurrency'
          }
          AccrualAmtInTransCrcy,
          @EndUserText: {
            label: 'Accrual Amt (CC)',
            quickInfo: 'Accrual Amount in Company Code Currency'
          }
          @Semantics: {
            amount.currencyCode: 'CompanyCodeCurrency'
          }
          AccrualAmtInCCCrcy,
          @EndUserText: {
            label: 'Accrual Amt (GC)',
            quickInfo: 'Accrual Amount in Global Currency'
          }
          @Semantics: {
            amount.currencyCode: 'GlobalCurrency'
          }
          AccrualAmtInGlobalCrcy,
          @EndUserText: {
            label: 'Pstd Amt CP (TC)',
            quickInfo: 'Posted Amount for Current Period in Transaction Currency'
          }
          @Semantics: {
            amount.currencyCode: 'TransactionCurrency'
          }
          PostedCurPeriodAmtInTransCrcy,
          @EndUserText: {
            label: 'Pstd Amt CP (CC)',
            quickInfo: 'Posted Amount for Current Period in Company Code Currency'
          }
          @Semantics: {
            amount.currencyCode: 'CompanyCodeCurrency'
          }
          PostedCurPeriodAmtInCoCodeCrcy,
          @EndUserText: {
            label: 'Pstd Amt CP (GC)',
            quickInfo: 'Posted Amount for Current Period in Global Currency'
          }
          @Semantics: {
            amount.currencyCode: 'GlobalCurrency'
          }
          PostedCurPeriodAmtInGlobalCrcy,
          @EndUserText: {
            label: 'Proposed Amt (TC)',
            quickInfo: 'Proposed Amount in Transaction Currency'
          }
          @Semantics: {
            amount.currencyCode: 'TransactionCurrency'
          }
          ProposedAccrAmtInTransCrcy,
          @EndUserText: {
            label: 'Proposed Amt (CC)',
            quickInfo: 'Proposed Amount in Company Code Currency'
          }
          @Semantics: {
            amount.currencyCode: 'CompanyCodeCurrency'
          }
          ProposedAccrAmtInCoCodeCrcy,
          @EndUserText: {
            label: 'Proposed Amt (GC)',
            quickInfo: 'Proposed Amount in Global Currency'
          }
          @Semantics: {
            amount.currencyCode: 'GlobalCurrency'
          }
          ProposedAccrAmtInGlobalCrcy,
          @EndUserText: {
            label: 'Actual Costs (TC)',
            quickInfo: 'Actual Costs in Transaction Currency'
          }
          @Semantics: {
            amount.currencyCode: 'TransactionCurrency'
          }
          ActualCostInTransCrcy,
          @EndUserText: {
            label: 'Actual Costs (CC)',
            quickInfo: 'Actual Costs in Company Code Currency'
          }
          @Semantics: {
            amount.currencyCode: 'CompanyCodeCurrency'
          }
          ActualCostAmtInCCCrcy,
          @EndUserText: {
            label: 'Actual Costs (GC)',
            quickInfo: 'Actual Costs in Global Currency'
          }
          @Semantics: {
            amount.currencyCode: 'GlobalCurrency'
          }
          ActualCostInGlobalCrcy,
          @EndUserText: {
            label: 'Planned Costs (TC)',
            quickInfo: 'Planned Costs in Transaction Currency'
          }
          @Semantics: {
            amount.currencyCode: 'TransactionCurrency'
          }
          PlannedCostInTransCrcy,
          @EndUserText: {
            label: 'Planned Costs (CC)',
            quickInfo: 'Planned Costs in Company Code Currency'
          }
          @Semantics: {
            amount.currencyCode: 'CompanyCodeCurrency'
          }
          PlndCostInCoCodeCrcy,
          @EndUserText: {
            label: 'Planned Costs (GC)',
            quickInfo: 'Planned Costs in Global Currency'
          }
          @Semantics: {
            amount.currencyCode: 'GlobalCurrency'
          }
          PlannedCostInGlobalCrcy,
          @EndUserText: {
            label: 'Recgnd Costs Bal(TC)',
            quickInfo: 'Recognized Costs (Balance) in Transaction Currency'
          }
          @Semantics: {
            amount.currencyCode: 'TransactionCurrency'
          }
          RecognizedCostInTransCrcy,
          @EndUserText: {
            label: 'Recgnd Costs Bal(CC)',
            quickInfo: 'Recognized Costs (Balance) in Company Code Currency'
          }
          @Semantics: {
            amount.currencyCode: 'CompanyCodeCurrency'
          }
          RecognizedCostInCoCodeCrcy,
          @EndUserText: {
            label: 'Recgnd Costs Bal(GC)',
            quickInfo: 'Recognized Costs (Balance) in Global Crcy'
          }
          @Semantics: {
            amount.currencyCode: 'GlobalCurrency'
          }
          RecognizedCostInGlobalCrcy,
          @EndUserText: {
            label: 'Dfrd Costs Bal. (TC)',
            quickInfo: 'Deferred Costs (Balance) in Transaction Currency'
          }
          @Semantics: {
            amount.currencyCode: 'TransactionCurrency'
          }
          DeferredCostInTransCrcy,
          @EndUserText: {
            label: 'Dfrd Costs Bal.(CC)',
            quickInfo: 'Deferred Costs (Balance) in Company Code Currency'
          }
          @Semantics: {
            amount.currencyCode: 'CompanyCodeCurrency'
          }
          DeferredCostInCoCodeCrcy,
          @EndUserText: {
            label: 'Dfrd Costs Bal. (GC)',
            quickInfo: 'Deferred Costs (Balance) in Global Currency'
          }
          @Semantics: {
            amount.currencyCode: 'GlobalCurrency'
          }
          DeferredCostInGlobalCrcy,
          @EndUserText: {
            label: 'Revised Costs (TC)',
            quickInfo: 'Revised Costs in Transaction Currency'
          }
          @Semantics: {
            amount.currencyCode: 'TransactionCurrency'
          }
          AdjustedCostInTransCrcy,
          @EndUserText: {
            label: 'Revised Costs (CC)',
            quickInfo: 'Revised Costs in Company Code Currency'
          }
          @Semantics: {
            amount.currencyCode: 'CompanyCodeCurrency'
          }
          AdjustedCostInCoCodeCrcy,
          @EndUserText: {
            label: 'Revised Costs (GC)',
            quickInfo: 'Revised Costs in Global Currency'
          }
          @Semantics: {
            amount.currencyCode: 'GlobalCurrency'
          }
          AdjustedCostInGlobalCrcy,

          @Semantics.amount.currencyCode: 'TransactionCurrency'
          CurPerdPostdAccrAmtInTransCrcy,

          // For texts only
          _AccrSubobjLifecycleStatusTxt.AccrSubobjLifeCycleStatusName,
          _AprvAccrApprvlStsTxt.ApprovalStatusText,
          _AprvAccrRevStsTxt.ReviewStatusText,
          _CompanyCode.CompanyCodeName,

          // Criticality
          @UI.hidden: true
          AccrAmtApprvlStsCritlty

          // WBSElement - Do not use conversion exit ABPSN for property WBSElement
}
