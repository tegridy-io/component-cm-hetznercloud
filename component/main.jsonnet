// main template for cm-hetznercloud
local kap = import 'lib/kapitan.libjsonnet';
local kube = import 'lib/kube.libjsonnet';
local inv = kap.inventory();
// The hiera parameters for the component
local params = inv.parameters.cm_hetznercloud;

// Define outputs below
{
}
