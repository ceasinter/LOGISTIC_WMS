@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LOGISTIQ - Status Transition - Root View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zr_status_transition
  as select from zlogi_t_sttrans
{
  key process_code     as ProcessCode,
  key from_status      as FromStatus,
  key to_status        as ToStatus,
      is_active        as IsActive,
      @Semantics.user.createdBy: true
      created_by       as CreatedBy,
      @Semantics.user.lastChangedBy: true
      last_changed_by  as LastChangedBy,
      @Semantics.user.localInstanceLastChangedBy: true
      local_changed_by as LocalChangedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at       as CreatedAt,      
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at  as LastChangedAt,      
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_changed_at as LocalChangedAt
}
