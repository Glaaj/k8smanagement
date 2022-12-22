#!/usr/bin/env fish
# If there's already a kubeconfig file in ~/.kube/config it will import that too and all the contexts
set DEFAULT_KUBECONFIG_FILE "$HOME/.kube/config"
if test -f "$DEFAULT_KUBECONFIG_FILE"
then
  export KUBECONFIG="$DEFAULT_KUBECONFIG_FILE"
end
# Your additional kubeconfig files should be inside ~/.kube/config-files
set ADD_KUBECONFIG_FILES "$HOME/.kube/config-files"
mkdir -p "$ADD_KUBECONFIG_FILES"
set OIFS "$IFS"
set IFS '\n'
for kubeconfigFile in `find "$ADD_KUBECONFIG_FILES" -type f -name "*.yml" -o -name "*.yaml"`
  end
export KUBECONFIG="$kubeconfigFile:$KUBECONFIG"
set IFS "$OIFS"