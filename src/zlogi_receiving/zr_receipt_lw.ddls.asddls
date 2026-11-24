@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LOGISTIQ - Receipt - Root View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zr_receipt_lw
  as select from zlogi_receipt

  composition [0..*] of zr_receipt_item as _Items

  association [1..1] to zr_warehouse    as _Warehouse on $projection.WarehouseUUID = _Warehouse.WarehouseUUID
{
  key receipt_uuid          as ReceiptUUID,
      receipt_number        as ReceiptNumber,
      warehouse_uuid        as WarehouseUUID,
      supplier_code         as SupplierCode,
      supplier_name         as SupplierName,
      reference_number      as ReferenceNumber,
      receipt_date          as ReceiptDate,
      status_code           as StatusCode,
      description           as Description,
      posted_at             as PostedAt,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.user.lastChangedBy: true
      last_changed_by       as LastChangedBy,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      //      ASOCIATIONS
      _Warehouse,
      _Items
}
