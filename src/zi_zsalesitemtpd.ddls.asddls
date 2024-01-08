@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forzsalesitem'
define view entity ZI_zsalesitemTPD
  as projection on ZR_zsalesitemTPD as zsalesitem
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
  _ch_test : redirected to parent ZI_ch_test01TPD
  
}
