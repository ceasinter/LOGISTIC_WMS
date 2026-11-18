@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LOGISTIQ - Status Root View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zr_status
  as select from zlogi_t_status
{
  key process_code          as ProcessCode,
  key status_code           as StatusCode,
      status_description    as StatusDescription,
      is_initial            as IsInitial,
      is_final              as IsFinal,
      is_active             as IsActive,
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
      local_last_changed_at as LocalLastChangedAt
}
