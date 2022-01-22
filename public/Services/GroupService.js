Type.registerNamespace('Roblox.Website.Services');
Roblox.Website.Services.GroupService=function() {
Roblox.Website.Services.GroupService.initializeBase(this);
this._timeout = 0;
this._userContext = null;
this._succeeded = null;
this._failed = null;
}
Roblox.Website.Services.GroupService.prototype={
_get_path:function() {
 var p = this.get_path();
 if (p) return p;
 else return Roblox.Website.Services.GroupService._staticInstance.get_path();},
GetRoleSetsForGroup:function(groupId,succeededCallback, failedCallback, userContext) {
return this._invoke(this._get_path(), 'GetRoleSetsForGroup',false,{groupId:groupId},succeededCallback,failedCallback,userContext); },
GetGroupPlaces:function(groupId,startRowIndex,maximumRows,succeededCallback, failedCallback, userContext) {
return this._invoke(this._get_path(), 'GetGroupPlaces',false,{groupId:groupId,startRowIndex:startRowIndex,maximumRows:maximumRows},succeededCallback,failedCallback,userContext); },
CanAddGroupPlaces:function(groupId,succeededCallback, failedCallback, userContext) {
return this._invoke(this._get_path(), 'CanAddGroupPlaces',false,{groupId:groupId},succeededCallback,failedCallback,userContext); }}
Roblox.Website.Services.GroupService.registerClass('Roblox.Website.Services.GroupService',Sys.Net.WebServiceProxy);
Roblox.Website.Services.GroupService._staticInstance = new Roblox.Website.Services.GroupService();
Roblox.Website.Services.GroupService.set_path = function(value) { Roblox.Website.Services.GroupService._staticInstance.set_path(value); }
Roblox.Website.Services.GroupService.get_path = function() { return Roblox.Website.Services.GroupService._staticInstance.get_path(); }
Roblox.Website.Services.GroupService.set_timeout = function(value) { Roblox.Website.Services.GroupService._staticInstance.set_timeout(value); }
Roblox.Website.Services.GroupService.get_timeout = function() { return Roblox.Website.Services.GroupService._staticInstance.get_timeout(); }
Roblox.Website.Services.GroupService.set_defaultUserContext = function(value) { Roblox.Website.Services.GroupService._staticInstance.set_defaultUserContext(value); }
Roblox.Website.Services.GroupService.get_defaultUserContext = function() { return Roblox.Website.Services.GroupService._staticInstance.get_defaultUserContext(); }
Roblox.Website.Services.GroupService.set_defaultSucceededCallback = function(value) { Roblox.Website.Services.GroupService._staticInstance.set_defaultSucceededCallback(value); }
Roblox.Website.Services.GroupService.get_defaultSucceededCallback = function() { return Roblox.Website.Services.GroupService._staticInstance.get_defaultSucceededCallback(); }
Roblox.Website.Services.GroupService.set_defaultFailedCallback = function(value) { Roblox.Website.Services.GroupService._staticInstance.set_defaultFailedCallback(value); }
Roblox.Website.Services.GroupService.get_defaultFailedCallback = function() { return Roblox.Website.Services.GroupService._staticInstance.get_defaultFailedCallback(); }
Roblox.Website.Services.GroupService.set_enableJsonp = function(value) { Roblox.Website.Services.GroupService._staticInstance.set_enableJsonp(value); }
Roblox.Website.Services.GroupService.get_enableJsonp = function() { return Roblox.Website.Services.GroupService._staticInstance.get_enableJsonp(); }
Roblox.Website.Services.GroupService.set_jsonpCallbackParameter = function(value) { Roblox.Website.Services.GroupService._staticInstance.set_jsonpCallbackParameter(value); }
Roblox.Website.Services.GroupService.get_jsonpCallbackParameter = function() { return Roblox.Website.Services.GroupService._staticInstance.get_jsonpCallbackParameter(); }
Roblox.Website.Services.GroupService.set_path("/Services/GroupService.asmx");
Roblox.Website.Services.GroupService.GetRoleSetsForGroup= function(groupId,onSuccess,onFailed,userContext) {Roblox.Website.Services.GroupService._staticInstance.GetRoleSetsForGroup(groupId,onSuccess,onFailed,userContext); }
Roblox.Website.Services.GroupService.GetGroupPlaces= function(groupId,startRowIndex,maximumRows,onSuccess,onFailed,userContext) {Roblox.Website.Services.GroupService._staticInstance.GetGroupPlaces(groupId,startRowIndex,maximumRows,onSuccess,onFailed,userContext); }
Roblox.Website.Services.GroupService.CanAddGroupPlaces= function(groupId,onSuccess,onFailed,userContext) {Roblox.Website.Services.GroupService._staticInstance.CanAddGroupPlaces(groupId,onSuccess,onFailed,userContext); }