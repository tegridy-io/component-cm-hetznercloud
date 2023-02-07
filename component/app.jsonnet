local kap = import 'lib/kapitan.libjsonnet';
local inv = kap.inventory();
local params = inv.parameters.cm_hetznercloud;
local argocd = import 'lib/argocd.libjsonnet';

local app = argocd.App('cm-hetznercloud', params.namespace);

{
  'cm-hetznercloud': app,
}
