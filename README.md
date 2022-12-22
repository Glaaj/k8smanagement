# k8smanagement

By default your kubernetes configuration lives in `~/.kube/config`.
Additional clusters get added into this file resulting in clutter.

I personnaly much rather have multiple kubeconfig files, one for each cluster I’m
managing, and name those files with some information that tells me which cluster
the file belongs to. This way the clusters are separated from one another which
simplifies management.

This is easily achieved by using `kubeconfig --kubeconfig=/path/to/my/kubeconfig/file/cluster1`.
But that is not a great solution for me since it’s time-consuming having to pass
your configuration every time you want to check which pods are running on a cluster.

What I have done to simplify having multiple kubeconfig files was to use a cool
capability of the `$KUBECONFIG` environment variable, which allows us to specify
multiple kubeconfig files separated
by using colons.

It should look like that when you have multiple config files:

``` bash
$KUBECONFIG=/Users/USERNAMEHERE/.kube/contexts/conf1.yml:/Users/USERNAMEHERE/.kube/contexts/conf2.yml
```

This will allow me to switch between the cluster-1 and cluster-2 contexts using ```kubectl config use-context cluster-1``` for example, this also integrates with `k9s` which I highy recommend: <https://k9scli.io/>.

This solves my problem of allowing me to have multiple config files, but still fairly manual since every time I restart my terminal or if I have a new kubeconfig (or I have to remove an old one) I have to set that environment variable again. For that, I use a very simple bash script that scans the directory for new files and automatically adds them to the $KUBECONFIG environment variable

## Bash shell script variant

If you want to have this loaded every time you open a terminal, you can add
`source /path/to/script/load-k8s-config.sh` to your `.bashrc` or `.zshrc`.

## Fish shell script variant

If you use the Fish shell, make sure to pick the correct variant from the repository.

If you want to have this loaded every time you open a terminal, you can add the following to `~/.config/fish/fish/.config` inside the `interactive` section:

`source /Users/glenneggen/Documents/gitrepos/k8smanagement/load-k8s-configs.sh`

Enjoy!
