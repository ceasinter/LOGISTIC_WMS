@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LOGISTIQ - Stock Movement - CV'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define root view entity zc_stock_mov
  provider contract transactional_query
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

      _Warehouse  : redirected to zc_warehouse,
      _StorageBin : redirected to zc_storage_bin,
      _Product    : redirected to zc_producto_lw,
      _StockType  : redirected to zc_stock_type,
      _Unit       : redirected to zc_units_meas
}
