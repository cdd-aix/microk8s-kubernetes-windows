$ErrorActionPreference = "Stop"
mkdir -force c:\k
copy -force c:\vagrant\.kube\config c:\k\config
Invoke-WebRequest https://docs.projectcalico.org/scripts/install-calico-windows.ps1 -OutFile c:\install-calico-windows.ps1
$kubeRawVersion = get-content "C:\vagrant\.kube\version"
$kubeVersion = $kubeRawVersion -replace "`n","" -replace "`r",""
# Note we are missing calico-system namespace
c:\install-calico-windows.ps1 -DownloadOnly yes -KubeVersion $kubeVersion
c:\CalicoWindows\install-calico.ps1
c:\CalicoWindows\kubernetes\install-kube-services.ps1
Start-Service kubelet
Start-Service kube-proxy
