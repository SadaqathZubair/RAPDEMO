@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forSalesOrder'
define root view entity ZI_SalesOrder04TPD
  provider contract transactional_interface
  as projection on ZR_SalesOrder04TPD as SalesOrder
{
  key HeaderUUID,
  SalesorderID,
  TotalAmount,
  CurrencyCode,
  Description,
  OverallStatus,
  CreatedAt,
  CreatedBy,
  LastChangedBy,
  LastChangedAt,
  LocalLastChangedAt,
  _Item : redirected to composition child ZI_Item02TPD
  
}
