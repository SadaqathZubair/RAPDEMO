@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forItem'
define view entity ZR_Item02TPD
  as select from ZDMO_UUID_ITEMd as Item
  association to parent ZR_SalesOrder04TPD as _SalesOrder on $projection.ParentUUID = _SalesOrder.HeaderUUID
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
  _SalesOrder
  
}
