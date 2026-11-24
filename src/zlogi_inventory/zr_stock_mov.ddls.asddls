@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LOGISTIQ - Stock Movement - Root View'
@Metadata.ignorePropagatedAnnotations: true

define root view entity zr_stock_mov
  as select from zlogi_stock_mov

  association [1..1] to zr_warehouse as _Warehouse
    on $projection.WarehouseUUID = _Warehouse.WarehouseUUID

  association [1..1] to zr_storage_bin as _StorageBin
    on $projection.StorageBinUUID = _StorageBin.StorageBinUUID

  association [1..1] to zr_product_lw as _Product
    on $projection.ProductUUID = _Product.ProductUUID

  association [1..1] to zr_stock_type as _StockType
    on $projection.StockTypeUUID = _StockType.StockTypeUUID

  association [0..1] to zr_units_meas as _Unit
    on $projection.UnitCode = _Unit.UnitCode

{
  key stock_movement_uuid as StockMovementUUID,

      movement_group_uuid as MovementGroupUUID,

      warehouse_uuid       as WarehouseUUID,
      storage_bin_uuid     as StorageBinUUID,
      product_uuid         as ProductUUID,
      stock_type_uuid      as StockTypeUUID,

      movement_direction   as MovementDirection,

      @Semantics.quantity.unitOfMeasure: 'UnitCode'
      quantity             as Quantity,

      unit_code            as UnitCode,

      reference_type       as ReferenceType,
      reference_number     as ReferenceNumber,

      reversal_of_uuid     as ReversalOfUUID,

      movement_at          as MovementAt,

      @Semantics.user.createdBy: true
      created_by           as CreatedBy,

      @Semantics.systemDateTime.createdAt: true
      created_at           as CreatedAt,

      _Warehouse,
      _StorageBin,
      _Product,
      _StockType,
      _Unit
}
