@EndUserText.label: 'contains parameter(s) to copy projects'
define abstract entity ZDMO_I_RAP_GEN_PARAM_COPY_PROd
{
// Use the same name as in the root view ZDMO_R_RapGeneratorBO
  @EndUserText.label: 'Package'
  @Consumption.valueHelpDefinition: [{entity: {name: 'ZDMO_I_RAP_GENERATOR_PACKAGED', element: 'name' }}]
  PackageName     : sxco_package;
}
