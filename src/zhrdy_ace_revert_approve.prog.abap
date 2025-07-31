*&---------------------------------------------------------------------*
*& Report ZHRDY_ACE_REVERT_APPROVE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZHRDY_ACE_REVERT_APPROVE.

UPDATE acesobj_item_per
  SET APPROVAL_STATUS = 'N' APPROVED_BY = '' APPROVED_ON = '00000000' ADJUSTED_AT = '000000'
WHERE ref_key = '5716435516' AND bukrs = '0001' AND comp = 'POAC'
  AND ( ref_subkey = '00010-01' OR ref_subkey = '00020-01' ).
