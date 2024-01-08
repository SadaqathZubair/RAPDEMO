@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View forch_test'
define root view entity ZI_ch_test01TPD
  provider contract transactional_interface
  as projection on ZR_ch_test01TPD as ch_test
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
  _zsalesitem : redirected to composition child ZI_zsalesitemTPD
  
}
