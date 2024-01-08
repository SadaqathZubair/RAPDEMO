@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forZsales'
define view entity ZI_ZsalesTPD
  as projection on ZR_ZsalesTPD as Zsales
{
  key ItemUUID,
  ParentUUID,
  ItemID,
  Quantity,
  QuantityUnit,
  Amount,
  CurrencyCode,
  Description,
  OverallStatus,
  LocalLastChangedAt,
  _zsalesTestG : redirected to parent ZI_zsalesTestG01TPD
  
}
