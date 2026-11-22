@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LOGISTIQ - Storage Bin - Root View'
@Metadata.ignorePropagatedAnnotations: true
define view entity zr_storage_bin
  as select from zlogi_stor_bin

  association        to parent zr_warehouse as _Warehouse   on $projection.WarehouseUUID = _Warehouse.WarehouseUUID
  association [1..1] to zr_storage_type     as _StorageType on $projection.StorageTypeUUID = _StorageType.StorageTypeUUID

{
  key storage_bin_uuid      as StorageBinUUID,
      warehouse_uuid        as WarehouseUUID,

      @ObjectModel.foreignKey.association: '_StorageType'
      @ObjectModel.text.association: '_StorageType'
      storage_type_uuid     as StorageTypeUUID,
      //      storage_type_uuid     as StorageTypeUUID,
      storage_bin_code      as StorageBinCode,
      storage_bin_name      as StorageBinName,
      aisle_code            as AisleCode,
      rack_code             as RackCode,
      level_code            as LevelCode,
      position_code         as PositionCode,
      description           as Description,
      is_active             as IsActive,

      //CAMPOS DE AUDITORÍA
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

      //      ASOCIACIONES
      _Warehouse,
      _StorageType
}
