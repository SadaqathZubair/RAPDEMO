@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forSalesOrder'
@ObjectModel.semanticKey: [ 'SalesorderID' ]
@Search.searchable: true
define root view entity ZC_SalesOrder04TPd
  provider contract transactional_query
  as projection on ZR_SalesOrder04TPd as SalesOrder
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
  _Item : redirected to composition child ZC_Item02TPd
  
}
