@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LOGISTIQ - Storage Type - I View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zi_storage_type
  provider contract transactional_interface
  as projection on zr_storage_type
{
  key StorageTypeUuid,
      StorageTypeCode,
      StorageTypeName,
      Description,
      IsActive,
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
      LocalLastChangedAt
}
