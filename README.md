☘ SUPPORT OS ☘  
  
➽ Debian 10 & 11 (recommended)   
➽ Ubuntu 20.04   

⚡️ INSTALASI ⚡️     

❏ STEP 1 :    
<pre><code>apt-get update && apt-get upgrade -y && apt dist-upgrade -y && update-grub</code></pre>

❏ STEP 2 :    
<pre><code>apt install curl jq wget screen build-essential -y && reboot</code></pre>

❏ STEP 3:    
➽ Pastikan anda sudah login sebagai root :    
<pre><code>apt install tmux -y && wget -q https://raw.githubusercontent.com/frosi4524/R051VPN/main/home && chmod +x home && tmux new-session -d -s rosivpn './home' && tmux attach -t rosivpn</code></pre>

❏ STEP 4 :     
➽ If during the installation connection was lost, login to the vps again and run the command ☞shell

<pre><code>tmux attach -t rosivpn</code></pre>
