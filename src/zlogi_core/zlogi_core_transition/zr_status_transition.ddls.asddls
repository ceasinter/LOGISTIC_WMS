@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LOGISTIQ - Status Transition - Root View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zr_status_transition
  as select from zlogi_t_sttrans
  association [0..1] to zr_status as _FromStatus on  $projection.ProcessCode = _FromStatus.ProcessCode
                                                 and $projection.FromStatus  = _FromStatus.StatusCode

  association [0..1] to zr_status as _ToStatus   on  $projection.ProcessCode = _ToStatus.ProcessCode
                                                 and $projection.ToStatus    = _ToStatus.StatusCode
{
  key process_code          as ProcessCode,
  key from_status           as FromStatus,
  key to_status             as ToStatus,
      is_allowed            as IsAllowed,
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
      _FromStatus,
      _ToStatus
}
