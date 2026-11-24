@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LOGISTIQ - Stock Movement - IV'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zi_stock_movement
provider contract transactional_interface
  as projection on zr_stock_mov
{
  key StockMovementUUID,
      MovementGroupUUID,
      WarehouseUUID,
      StorageBinUUID,
      ProductUUID,
      StockTypeUUID,
      MovementDirection,
      @Semantics.quantity.unitOfMeasure: 'UnitCode'
      Quantity,
      UnitCode,
      ReferenceType,
      ReferenceNumber,
      ReversalOfUUID,
      MovementAt,
      @Semantics.user.createdBy: true
      CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      CreatedAt,
      /* Associations */
      _Product,
      _StockType,
      _StorageBin,
      _Unit,
      _Warehouse
}
