@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LOGISTIQ - Receipt - Consumption View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity zc_receipt_lw
  provider contract transactional_query
  as projection on zr_receipt_lw
{
  key ReceiptUUID,
      ReceiptNumber,
      @ObjectModel.text.element: ['WarehouseName']
      WarehouseUUID,
      SupplierCode,
      SupplierName,
      ReferenceNumber,
      ReceiptDate,
      StatusCode,
      Description,
      PostedAt,
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
      _Warehouse.WarehouseCode as WarehouseCode,
      _Warehouse.WarehouseName as WarehouseName,
      /* Associations */
      _Items     : redirected to composition child zc_receipt_items,
      _Warehouse : redirected to zc_warehouse
}
