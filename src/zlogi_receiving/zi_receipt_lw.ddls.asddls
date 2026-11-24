@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LOGISTIQ - Receipt - Interface View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zi_receipt_lw
  provider contract transactional_interface
  as projection on zr_receipt_lw
{
  key ReceiptUUID,
      ReceiptNumber,
      WarehouseUuid,
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
      /* Associations */
      _Items,
      _Warehouse
}
