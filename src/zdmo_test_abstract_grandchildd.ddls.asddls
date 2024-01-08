@EndUserText.label: 'Test entity - abstract - child'
@OData.entitySet.name: 'ScheduleLineItemSet'
@OData.entityType.name: 'ScheduleLineItem'
define abstract entity ZDMO_TEST_ABSTRACT_GRANDCHILDD
{
  key SalesOrderID    : abap.char( 10 );
  key ItemPosition    : abap.char( 10 );
  key ScheduleLine    : abap.numc( 4 );

      DeliveryDate    : rap_cp_odata_v2_edm_datetime;
      @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
      Quantity        : abap.dec( 13, 2 );
      @Semantics.unitOfMeasure: true
      QuantityUnit    : abap.unit( 3 );
 

      @OData.property.name: 'ToHeader'
      //A dummy on-condition is required for associations in abstract entities
      //On-condition is not relevant for runtime
      _ToItem       : association [1] to zdmo_test_abstract_childentitd on 1 = 1;

}
