local kap = import 'lib/kapitan.libjsonnet';
local inv = kap.inventory();
local params = inv.parameters.cm_hetznercloud;
local argocd = import 'lib/argocd.libjsonnet';

local app = argocd.App('cm-hetznercloud', params.namespace);

local appPath =
  local project = std.get(std.get(app, 'spec', {}), 'project', 'syn');
  if project == 'syn' then 'apps' else 'apps-%s' % project;

{
  ['%s/cm-hetznercloud' % appPath]: app,
}
