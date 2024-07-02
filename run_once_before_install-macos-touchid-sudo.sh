{{- if eq .chezmoi.os "darwin" -}}
#!/bin/bash
grep "pam_tid" /etc/pam.d/sudo
if [ "$?" -ne "0" ]; then
sudo sed -ie '2i\
auth sufficient pam_tid.so 
' /etc/pam.d/sudo
fi
{{ end -}}
