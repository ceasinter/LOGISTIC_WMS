@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LOGISTIQ - Stock Balance - Root View'
@Metadata.ignorePropagatedAnnotations: true

define root view entity zr_stock_bal
  as select from zlogi_stock_bal

  association [1..1] to zr_warehouse as _Warehouse
    on $projection.WarehouseUUID = _Warehouse.WarehouseUUID

  association [1..1] to zr_storage_bin as _StorageBin
    on $projection.StorageBinUUID = _StorageBin.StorageBinUUID

  association [1..1] to zr_product_lw as _Product
    on $projection.ProductUUID = _Product.ProductUUID

  association [1..1] to zr_stock_type as _StockType
    on $projection.StockTypeUUID = _StockType.StockTypeUUID

  association [1..1] to zr_units_meas as _Unit
    on $projection.UnitCode = _Unit.UnitCode

{
  key stock_balance_uuid as StockBalanceUUID,

      warehouse_uuid as WarehouseUUID,
      storage_bin_uuid as StorageBinUUID,
      product_uuid as ProductUUID,
      stock_type_uuid as StockTypeUUID,

      @Semantics.quantity.unitOfMeasure: 'UnitCode'
      quantity as Quantity,
      
      unit_code as UnitCode,

      last_movement_at as LastMovementAt,

      @Semantics.user.createdBy: true
      created_by as CreatedBy,

      @Semantics.user.lastChangedBy: true
      last_changed_by as LastChangedBy,

      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,

      @Semantics.systemDateTime.createdAt: true
      created_at as CreatedAt,

      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as LastChangedAt,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      _Warehouse,
      _StorageBin,
      _Product,
      _StockType,
      _Unit
}
