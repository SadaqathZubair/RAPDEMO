@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forZsales'
@ObjectModel.semanticKey: [ 'ParentUUID' ]
@Search.searchable: true
define view entity ZC_ZsalesTPd
  as projection on ZR_ZsalesTPd as Zsales
{
  key ItemUUID,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  ParentUUID,
  ItemID,
  @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
  Quantity,
  @Semantics.unitOfMeasure: true
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: 'I_UnitOfMeasure', 
      element: 'UnitOfMeasure'
    }, 
    useForValidation: true
  } ]
  QuantityUnit,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  Amount,
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
  LocalLastChangedAt,
  _zsalesTestG : redirected to parent ZC_zsalesTestG01TPd
  
}
