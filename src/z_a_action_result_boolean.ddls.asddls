@EndUserText.label: 'Abstract Entity for Boolean Action Result'
define abstract entity Z_A_ACTION_RESULT_BOOLEAN
{
  key AccrualEngineAccrualObjectType : ace_comp;
  key AccrualObjectLogicalSystem     : ace_logsys;
  key CompanyCode                    : ace_bukrs;
  key AccrualObject                  : ace_obj_id;
  key AccrualSubobject               : ace_subobj_id;
  key AccrualItemType                : ace_itemtype;
  key Ledger                         : fins_ledger;
  key AccrualPeriodEndDate           : ace_period_end_date;
      Success                        : abap_boolean;
      Message                        : abap.char(255); // Optional: A message to return to the UI
}
