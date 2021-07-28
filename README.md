# k8smanagement

 much rather have multiple kubeconfig files, one for each cluster I’m managing and name those files with some information that tells me which cluster the file belongs to. This is easily achieved by using `kubeconfig --kubeconfig=/path/to/my/kubeconfig/file/cluster1`. But that is not a great solution for me since it’s time-consuming having to pass your configuration every time you want to check which pods are running on a cluster.

What I have done to simplify having multiple kubeconfig files was to use a cool capability of the `$KUBECONFIG` environment variable, which allows us to specify multiple kubeconfig files separated 
by using colons. 

It should look like that when you have multiple config files:
```
$KUBECONFIG=/Users/glenneggen/.kube/contexts/kubeconfig-cluster-1.yml:/Users/glenneggen/.kube/contexts/kubeconfig-cluster-2.yml
```

This will allow me to switch between the cluster-1 and cluster-2 contexts using ```kubectl config use-context cluster-1``` for example.


# Script

This solves my problem of allowing me to have multiple config files, but still fairly manual since every time I restart my terminal or if I have a new kubeconfig (or I have to remove an old one) I have to set that environment variable again. For that, I use a very simple bash script that scans the directory for new files and automatically adds them to the $KUBECONFIG environment variable:

```
#!/usr/bin/env bash
# If there's already a kubeconfig file in ~/.kube/config it will import that too and all the contexts
DEFAULT_KUBECONFIG_FILE="$HOME/.kube/config"
if test -f "${DEFAULT_KUBECONFIG_FILE}"
then
  export KUBECONFIG="$DEFAULT_KUBECONFIG_FILE"
fi

# Your additional kubeconfig files should be inside ~/.kube/config-files
ADD_KUBECONFIG_FILES="$HOME/.kube/config-files"
mkdir -p "${ADD_KUBECONFIG_FILES}"
OIFS="$IFS"
IFS=$'\n'
for kubeconfigFile in `find "${ADD_KUBECONFIG_FILES}" -type f -name "*.yml" -o -name "*.yaml"`
do
    export KUBECONFIG="$kubeconfigFile:$KUBECONFIG"
done
IFS="$OIFS" 
```


Then you can source that script by typing `source load-k8s-configs.sh` on your Mac terminal and that will load all your kubeconfig files as part of your `$KUBECONFIG` environment variable.

If you want to have this loaded every time you open the terminal, you can add `source /path/to/script/load-k8s-config.sh` to your bash_profile file inside your home directory.
