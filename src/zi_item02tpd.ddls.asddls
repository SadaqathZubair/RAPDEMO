@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forItem'
define view entity ZI_Item02TPD
  as projection on ZR_Item02TPD as Item
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
  _SalesOrder : redirected to parent ZI_SalesOrder04TPD
  
}
