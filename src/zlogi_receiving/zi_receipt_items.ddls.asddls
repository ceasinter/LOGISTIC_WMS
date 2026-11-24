@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LOGISTIQ - Receipt Items - IV'
@Metadata.ignorePropagatedAnnotations: true
define view entity zi_receipt_items
  provider contract transactional_interface
  as projection on zr_receipt_item
{
  key ReceiptItemUUID,
      ReceiptUUID,
      ItemNumber,
      ProductUUID,
      StorageBinUUID,
      StockTypeUUID,

      @Semantics.quantity.unitOfMeasure: 'UnitCode'
      ExpectedQuantity,
      @Semantics.quantity.unitOfMeasure: 'UnitCode'
      ReceivedQuantity,
      UnitCode,
      Description,
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
      _Product,
      _Receipt,
      _StockType,
      _StorageBin,
      _Unit
}
