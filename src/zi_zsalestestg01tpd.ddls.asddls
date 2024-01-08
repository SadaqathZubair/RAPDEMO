@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forzsalesTestG'
define root view entity ZI_zsalesTestG01TPD
  provider contract transactional_interface
  as projection on ZR_zsalesTestG01TPD as zsalesTestG
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
  _Zsales : redirected to composition child ZI_ZsalesTPD
  
}
