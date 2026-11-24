@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LOGISTIQ - Receipt Item - Root View'
@Metadata.ignorePropagatedAnnotations: true

define view entity zr_receipt_item
  as select from zlogi_rec_item

  association to parent zr_receipt_lw as _Receipt
    on $projection.ReceiptUUID = _Receipt.ReceiptUUID

  association [1..1] to zr_product_lw as _Product
    on $projection.ProductUUID = _Product.ProductUUID

  association [1..1] to zr_storage_bin as _StorageBin
    on $projection.StorageBinUUID = _StorageBin.StorageBinUUID

  association [1..1] to zr_stock_type as _StockType
    on $projection.StockTypeUUID = _StockType.StockTypeUUID

  association [0..1] to zr_units_meas as _Unit
    on $projection.UnitCode = _Unit.UnitCode

{
  key receipt_item_uuid as ReceiptItemUUID,

      receipt_uuid      as ReceiptUUID,
      item_number       as ItemNumber,

      product_uuid      as ProductUUID,
      storage_bin_uuid  as StorageBinUUID,
      stock_type_uuid   as StockTypeUUID,

      @Semantics.quantity.unitOfMeasure: 'UnitCode'
      expected_quantity as ExpectedQuantity,

      @Semantics.quantity.unitOfMeasure: 'UnitCode'
      received_quantity as ReceivedQuantity,

      unit_code         as UnitCode,

      description       as Description,

      @Semantics.user.createdBy: true
      created_by        as CreatedBy,

      @Semantics.systemDateTime.createdAt: true
      created_at        as CreatedAt,

      @Semantics.user.lastChangedBy: true
      last_changed_by   as LastChangedBy,

      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at   as LastChangedAt,

      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      _Receipt,
      _Product,
      _StorageBin,
      _StockType,
      _Unit
}
