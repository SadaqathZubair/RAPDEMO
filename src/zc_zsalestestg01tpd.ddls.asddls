@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forzsalesTestG'
@ObjectModel.semanticKey: [ 'HeaderUUID' ]
@Search.searchable: true
define root view entity ZC_zsalesTestG01TPd
  provider contract transactional_query
  as projection on ZR_zsalesTestG01TPd as zsalesTestG
{
  key HeaderUUID,
  SalesorderID,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  TotalAmount,
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: 'I_Currency', 
      element: 'Currency'
    }, 
    useForValidation: true
  } ]
  CurrencyCode,
  Description,
  OverallStatus,
  CreatedAt,
  CreatedBy,
  LastChangedBy,
  LastChangedAt,
  LocalLastChangedAt,
  _Zsales : redirected to composition child ZC_ZsalesTPd
  
}
