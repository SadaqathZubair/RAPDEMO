@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forSalesOrder'
define root view entity ZR_SalesOrder04TPd
  as select from ZDMO_UUID_HEADEd as SalesOrder
  composition [0..*] of ZR_Item02TPd as _Item
{
  key HEADER_UUID as HeaderUUID,
  SALESORDER_ID as SalesorderID,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  TOTAL_AMOUNT as TotalAmount,
  CURRENCY_CODE as CurrencyCode,
  DESCRIPTION as Description,
  OVERALL_STATUS as OverallStatus,
  @Semantics.systemDateTime.createdAt: true
  CREATED_AT as CreatedAt,
  @Semantics.user.createdBy: true
  CREATED_BY as CreatedBy,
  @Semantics.user.lastChangedBy: true
  LAST_CHANGED_BY as LastChangedBy,
  @Semantics.systemDateTime.lastChangedAt: true
  LAST_CHANGED_AT as LastChangedAt,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  _Item
  
}
