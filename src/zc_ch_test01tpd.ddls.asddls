@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forch_test'
@ObjectModel.semanticKey: [ 'SalesorderID' ]
@Search.searchable: true
define root view entity ZC_ch_test01TPd
  provider contract transactional_query
  as projection on ZR_ch_test01TPd as ch_test
{
  key HeaderUUID,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
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
  _zsalesitem : redirected to composition child ZC_zsalesitemTPd
  
}
