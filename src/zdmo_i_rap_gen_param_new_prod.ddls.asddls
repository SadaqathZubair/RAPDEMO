@EndUserText.label: 'Parameter(s) to create new projects'
define abstract entity ZDMO_I_RAP_GEN_PARAM_NEW_PROd
{

//  @UI.defaultValue       : 'table'
  @EndUserText.label     : 'Datasource Type'
  @Consumption.valueHelpDefinition: [{entity: {name: 'ZDMO_I_RAP_GENERATOR_DSRC_TYPD', element: 'type' }}]
  DataSourceType         : abap.char(30);
//  @UI.defaultValue       : 'managed'
  @EndUserText.label     : 'Implementation type'
  @Consumption.valueHelpDefinition: [{entity: {name: 'ZDMO_I_RAP_GENERATOR_IMPL_TYPD', element: 'name' }}]

  BdefImplementationType : abap.char(50);
//  @UI.defaultValue       : 'odata_v4_ui'
  @EndUserText.label     : 'Binding type'
  @Consumption.valueHelpDefinition: [{entity: {name: 'ZDMO_I_RAP_GENERATOR_BIND_TYPD', element: 'name' }}]
  BindingType            : abap.char(30);
//  @UI.defaultValue       : 'X'
  @EndUserText.label     : 'Draft enabled'
  @Consumption.valueHelpDefinition: [{entity: {name: 'ZDMO_I_RAP_GENERATOR_BOOL_VHD', element: 'bool_value' }}]
  DraftEnabled           : abap_boolean;

  @EndUserText.label     : 'Root Entity Name'
  EntityName             : zdmo_rap_gen_entitynamed;

  @Consumption.valueHelpDefinition: [{ entity:
  { name                 : 'ZDMO_I_RAP_GENERATOR_DATA_SRCD' ,  element: 'name' }
                                       ,
                            additionalBinding: [{ element: 'type',
                                                  localElement: 'DataSourceType' }]
                                                  }]
  @EndUserText.label     : 'Data Source Name'
  data_source_name       : abap.char(30);

  @EndUserText.label     : 'Package'
  @Consumption.valueHelpDefinition: [{entity: {name: 'ZDMO_I_RAP_GENERATOR_PACKAGED', element: 'name' }}]
  package_name           : abap.char(30);

}
