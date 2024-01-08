@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forzsalesitem'
define view entity ZR_zsalesitemTPd
  as select from ZDMO_UUID_ITEMd as zsalesitem
  association to parent ZR_ch_test01TPd as _ch_test on $projection.ParentUUID = _ch_test.HeaderUUID
{
  key ITEM_UUID as ItemUUID,
  PARENT_UUID as ParentUUID,
  ITEM_ID as ItemID,
  @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
  QUANTITY as Quantity,
  QUANTITY_UNIT as QuantityUnit,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  AMOUNT as Amount,
  CURRENCY_CODE as CurrencyCode,
  DESCRIPTION as Description,
  OVERALL_STATUS as OverallStatus,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  _ch_test
  
}
