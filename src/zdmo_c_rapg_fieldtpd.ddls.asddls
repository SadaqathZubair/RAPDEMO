@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forField'
@ObjectModel.semanticKey: [ 'DbtableField' ]
@Search.searchable: true
define view entity ZDMO_C_RAPG_FieldTPd
  as projection on ZDMO_R_RAPG_FieldTPd
{
  key FieldUUID,
  NodeUUID,
  RapboUUID,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  DbtableField,
  CdsViewField,
  LocalLastChangedAt,
  _Node : redirected to parent ZDMO_C_RAPG_NodeTPd,
  _Project : redirected to ZDMO_C_RAPG_ProjectTPd
  
}
