# k8smanagement

What I have done to simplify having multiple kubeconfig files was to use a cool capability of the $KUBECONFIG environment variable, which allows us to specify multiple kubeconfig files separated 
by using colons. It should look like that when you have multiple config files:
$KUBECONFIG=/Users/aguedes/.kube/contexts/kubeconfig-cluster-1.yml:/Users/aguedes/.kube/contexts/kubeconfig-cluster-2.yml
This will allow me to switch between the cluster-1 and cluster-2 contexts using kubectl config use-context cluster-1for example.
This solves my problem of allowing me to have multiple config files, but still fairly manual since every time I restart my terminal or if I have a new kubeconfig (or I have to remove an old one) I have to set that environment variable again. For that, I use a very simple bash script that scans the directory for new files and automatically adds them to the $KUBECONFIG environment variable:
