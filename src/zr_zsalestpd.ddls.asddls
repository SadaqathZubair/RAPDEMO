@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forZsales'
define view entity ZR_ZsalesTPd
  as select from zdmo_uuid_itemd as Zsales
  association to parent ZR_zsalesTestG01TPd as _zsalesTestG on $projection.ParentUUID = _zsalesTestG.HeaderUUID
{
  key item_uuid as ItemUUID,
  parent_uuid as ParentUUID,
  item_id as ItemID,
  @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
  quantity as Quantity,
  quantity_unit as QuantityUnit,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  amount as Amount,
  currency_code as CurrencyCode,
  description as Description,
  overall_status as OverallStatus,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  _zsalesTestG
  
}
