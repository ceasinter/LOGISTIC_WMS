@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LOGISTIQ - Receipt Items - CV'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity zc_receipt_items
  //provider contract transactional_query
  as projection on zr_receipt_item
{
  key ReceiptItemUUID,
      ReceiptUUID,
      ItemNumber,
      @ObjectModel.text.element: ['ProductName']
      ProductUUID,
      @ObjectModel.text.element: ['StorageBinName']
      StorageBinUUID,
      @ObjectModel.text.element: ['StockTypeName']
      StockTypeUUID,
      @Semantics.quantity.unitOfMeasure: 'UnitCode'
      ExpectedQuantity,
      @Semantics.quantity.unitOfMeasure: 'UnitCode'
      ReceivedQuantity,
      @ObjectModel.text.element: ['UnitName']
      UnitCode,
      Description,

      _Product.ProductName       as ProductName,
      _StorageBin.StorageBinName as StorageBinName,
      _StockType.StockTypeName   as StockTypeName,
      _Unit.UnitName             as UnitName,
      @Semantics.user.createdBy: true
      CreatedBy,
      @Semantics.user.lastChangedBy: true
      LastChangedBy,
      @Semantics.user.localInstanceLastChangedBy: true
      LocalLastChangedBy,
      @Semantics.systemDateTime.createdAt: true
      CreatedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,
      /* Associations */
      _Product    : redirected to zc_producto_lw,
      _Receipt    : redirected to parent zc_receipt_lw,
      _StockType  : redirected to zc_stock_type,
      _StorageBin : redirected to zc_storage_bin,
      _Unit       : redirected to zc_units_meas
}
