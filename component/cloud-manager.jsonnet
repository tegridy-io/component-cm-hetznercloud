// main template for cm-hetznercloud
local com = import 'lib/commodore.libjsonnet';
local kap = import 'lib/kapitan.libjsonnet';
local kube = import 'lib/kube.libjsonnet';
local inv = kap.inventory();
// The hiera parameters for the component
local params = inv.parameters.cm_hetznercloud;

local controllerManager = com.Kustomization(
  'https://github.com/hetznercloud/hcloud-cloud-controller-manager//deploy',
  params.manifestVersion,
  {
    'hetznercloud/hcloud-cloud-controller-manager': {
      newTag: params.images.controller_manager.tag,
      newName: '%(registry)s/%(repository)s' % params.images.controller_manager,
    },
  },
  {
    patchesStrategicMerge: [
      'deployment.yaml',
    ],
  } + com.makeMergeable(params.kustomizeInput),
) {
  deployment: kube.Deployment('hcloud-cloud-controller-manager') {
    metadata+: {
      labels: {},
      namespace: params.namespace,
    },
    spec: {
      template: {
        spec: {
          containers: [
            {
              name: 'hcloud-cloud-controller-manager',
              env: [
                {
                  name: 'HCLOUD_NETWORK',
                  valueFrom: {
                    secretKeyRef: {
                      key: 'network',
                      name: 'hcloud',
                    },
                  },
                },
              ],
            },
          ],
        },
      },
    },
  },
};

controllerManager
