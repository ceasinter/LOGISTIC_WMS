@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LOGISTIQ - Status Transition - IView'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zi_status_transition
  provider contract transactional_interface
  as projection on zr_status_transition
{
  key ProcessCode,
  key FromStatus,
  key ToStatus,
      IsAllowed,
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

      //        ASOCIACIONES
      _FromStatus : redirected to zi_status,
      _ToStatus   : redirected to zi_status
}
